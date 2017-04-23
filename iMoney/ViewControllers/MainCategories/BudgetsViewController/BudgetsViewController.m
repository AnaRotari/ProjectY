//
//  BudgetsViewController.m
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BudgetsViewController.h"
#import "CreateBudgetViewController.h"
#import "BudgetsDetailViewController.h"
#import "BudgetTableViewCell.h"

@interface BudgetsViewController ()

@property (strong, nonatomic) NSMutableArray <Budget *> *budgetsArray;

@end

@implementation BudgetsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    [self.budgetsTableView registerNib:[UINib nibWithNibName:@"BudgetTableViewCell" bundle:nil] forCellReuseIdentifier:@"BudgetTableViewCell"];
    self.budgetsTableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self reloadDataForIndex:BudgetIntervalAll];
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addBudgetButtonAction)];
    
    UIBarButtonItem *sortButton = [iMoneyUtils getNavigationButton:@"ic_sort"
                                                            target:self
                                                       andSelector:@selector(sortBudgetsButtonAction)];
    
    self.navigationItem.rightBarButtonItems = @[addButton,sortButton];
}

- (void)reloadDataForIndex:(NSInteger)index {
    
    self.budgetsArray = [CoreDataBudgetManager getAllBudgetsForInterval:index].mutableCopy;
    self.noBudgetsLabel.hidden = self.budgetsArray.count;
    [self.budgetsTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Button actions

- (void)sortBudgetsButtonAction {

    [self showSortActionSheet:@[@"Weekly budgets",@"Monthly budgets",@"Yearly budgets",@"All"]];
}

- (void)addBudgetButtonAction {
    
    if ([CoreDataRequestManager getAllWallets].count > 0)
    {
        CreateBudgetViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateBudgetViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"You should create a wallet first !"];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)showSortActionSheet:(NSArray <NSString *> *)sortOptionsArray {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"Sorting options";
    actionSheet.delegate = self;
    
    for (NSString *option in sortOptionsArray) {
        
        [actionSheet addButtonWithTitle:option];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView: self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [self reloadDataForIndex:buttonIndex];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.budgetsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BudgetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BudgetTableViewCell" forIndexPath:indexPath];
    [cell setupCellWithBudgetDetails:self.budgetsArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BudgetsDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"BudgetsDetailViewController"];
    controller.selectedBudget = self.budgetsArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
        NSError *error = nil;
        [context deleteObject:self.budgetsArray[indexPath.row]];
        [self.budgetsArray removeObjectAtIndex:indexPath.row];
        if (![context save:&error]) {
            NSLog(@"Can't delete: %@",[error localizedDescription]);
        }
        [self reloadDataForIndex:BudgetIntervalAll];
    }
}

@end
