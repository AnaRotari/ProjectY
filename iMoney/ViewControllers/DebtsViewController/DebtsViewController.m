//
//  DebtsViewController.m
//  iMoney
//
//  Created by Alex on 4/21/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "DebtsViewController.h"
#import "DebtsTableViewCell.h"
#import "DebtsDetailViewController.h"

@interface DebtsViewController ()

@end

@implementation DebtsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpNavigationControllerButtons];
    [self prepareTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self reloadDataForIndex:BudgetsSortByCreationDateNewest];
}

- (void)setUpNavigationControllerButtons {
    
    self.title = @"Debts";
    UIBarButtonItem *addDebtsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                        target:self
                                                                                        action:@selector(addDebtsButtonAction)];
    
    UIBarButtonItem *editDebtsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                        target:self
                                                                                        action:@selector(editDebtsButtonAction)];
    
    UIBarButtonItem *sortButton = [iMoneyUtils getNavigationButton:@"ic_sort"
                                                            target:self
                                                       andSelector:@selector(sortButtonAction)];
    
    self.navigationItem.rightBarButtonItems = @[addDebtsButton, sortButton, editDebtsButton];
}

- (void)prepareTableView {
    
    [self.debtsTableView registerNib:[UINib nibWithNibName:@"DebtsTableViewCell" bundle:nil] forCellReuseIdentifier:@"DebtsTableViewCell"];
    self.debtsTableView.tableFooterView = [UIView new];
}

-(void)reloadDataForIndex:(NSInteger)index {
    
//    self.plannedArray = [CoreDataPlannedPaymentsManager getAllPlannedPayments:index];
//    self.plannedArray.count ? [self.plannedListLabel setHidden:YES] : [self.plannedListLabel setHidden:NO];
//    [self.plannedPaymentsTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
//                                 withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - Button actions

- (void)addDebtsButtonAction {
    
    DebtsDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DebtsDetailViewController"];
    controller.debtStatus = DebtStatusAdd;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)editDebtsButtonAction {
    
    self.debtsTableView.isEditing ? [self.debtsTableView setEditing:NO animated:YES] : [self.debtsTableView setEditing:YES animated:YES];
}

- (void)sortButtonAction {
    
    [self showSortActionSheet:@[@"By creation date - newest",
                                @"By creation date - oldest",
                                @"By name - A->Z",
                                @"By name - Z->A",
                                @"By amount - Ascending",
                                @"By amount - Descending"]];
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
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DebtsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DebtsTableViewCell" forIndexPath:indexPath];
//    [cell initCellWithPayment:self.plannedArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    PlannedPaymentsCreatorViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PlannedPaymentsCreatorViewController"];
//    controller.plannedPayment = self.plannedArray[indexPath.row];
//    [self.navigationController pushViewController:controller animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
//    PlannedPayments *plannedPayment = self.plannedArray[sourceIndexPath.row];
//    
//    [self.plannedArray removeObjectAtIndex:sourceIndexPath.row];
//    [self.plannedArray insertObject:plannedPayment atIndex:destinationIndexPath.row];
//    
//    int i = 1;
//    for (PlannedPayments *item in self.plannedArray) {
//        item.plannedSort = i++;
//    }
//    
//    [[CoreDataAccessLayer sharedInstance] saveContext];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//        [PlannedPaymentsNotificationManager deleteScheduledNotificationForPlannedPayment:self.plannedArray[indexPath.row]];
//        NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
//        NSError *error = nil;
//        
//        [context deleteObject:self.plannedArray[indexPath.row]];
//        
//        if (![context save:&error]) {
//            NSLog(@"Can't delete: %@",[error localizedDescription]);
//        }
//        
//        [self.plannedArray removeObjectAtIndex:indexPath.row];
//        self.plannedArray.count ? [self.plannedListLabel setHidden:YES] : [self.plannedListLabel setHidden:NO];
//        [self.plannedPaymentsTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
//                                     withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
