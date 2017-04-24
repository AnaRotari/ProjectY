//
//  DebtsViewController.m
//  iMoney
//
//  Created by Alex on 4/21/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "DebtsViewController.h"

typedef NS_ENUM(NSInteger, ActionSheetType)
{
    ActionSheetTypeSort = 0,
    ActionSheetTypeCloseDebt
};

typedef NS_ENUM(NSInteger, CloseDebtOption)
{
    CloseDebtOptionFull = 0,
    CloseDebtOptionPartial
};

@interface DebtsViewController ()

@property (strong, nonatomic) NSMutableArray <Debt *> *debtsArray;
@property (assign, nonatomic) NSInteger selectedDebtForClose;

@end

@implementation DebtsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpNavigationControllerButtons];
    [self prepareTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self reloadDataForIndex:DebtsSortByCreationDateNewest];
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
    
    self.debtsArray = [CoreDataDebtManager getAllDebts:index];
    self.bedtsLabel.hidden = self.debtsArray.count;
    [self.debtsTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                       withRowAnimation:UITableViewRowAnimationFade];
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
                                @"By amount - Descending"]
                    withTitle:@"Sorting options"
                 andActionTag:ActionSheetTypeSort];
}

#pragma mark - UIActionSheetDelegate

- (void)showSortActionSheet:(NSArray <NSString *> *)sortOptionsArray withTitle:(NSString *)title andActionTag:(NSInteger) actionType{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = title;
    actionSheet.delegate = self;
    actionSheet.tag = actionType;
    
    for (NSString *option in sortOptionsArray) {
        
        [actionSheet addButtonWithTitle:option];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView: self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        
        if (actionSheet.tag == ActionSheetTypeSort)
        {
            [self reloadDataForIndex:buttonIndex];
        }
        if (actionSheet.tag == ActionSheetTypeCloseDebt)
        {
            if(buttonIndex == CloseDebtOptionFull)
            {
                [self closeDebtFull];
            }
            if(buttonIndex == CloseDebtOptionPartial)
            {
                [self closeDebtPartial];
            }
        }
    }
}

- (void)closeDebtFull {
    
    Debt *selectedDebt = self.debtsArray[self.selectedDebtForClose];
    NSDecimalNumber *insuficient = [[NSDecimalNumber alloc] init];
    insuficient = [selectedDebt.debtTotalAmount decimalNumberBySubtracting:selectedDebt.debtCurrentAmount];
    selectedDebt.debtCurrentAmount = insuficient;
    [[CoreDataAccessLayer sharedInstance] saveContext];
    [CoreDataDebtManager createNewRecordForDebt:selectedDebt withAmount:insuficient.stringValue];
    [self reloadDataForIndex:DebtsSortByCreationDateNewest];
}

- (void)closeDebtPartial {
    
    MRAlertView *alertView = [[MRAlertView alloc] initWithTitle:@"Amount"
                                                        message:@"Enter value"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK"];
    [alertView setAlertViewStyle:MRAlertViewStylePlainTextInput];
    [alertView show];
}

#pragma mark - MRAlertViewDelegate

- (void)alertView:(MRAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1)
    {
        if ([alertView.textView.text length] > 0)
        {
            Debt *selectedDebt = self.debtsArray[self.selectedDebtForClose];
            [CoreDataDebtManager createNewRecordForDebt:selectedDebt withAmount:alertView.textView.text];
            selectedDebt.debtCurrentAmount = [selectedDebt.debtCurrentAmount decimalNumberByAdding:[[NSDecimalNumber alloc] initWithString:alertView.textView.text]];
            [[CoreDataAccessLayer sharedInstance] saveContext];
            [self reloadDataForIndex:DebtsSortByCreationDateNewest];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.debtsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DebtsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DebtsTableViewCell" forIndexPath:indexPath];
    [cell initCellWithDebt:self.debtsArray[indexPath.row]];
    cell.delegate = self;
    cell.transactionsButtonOutlet.tag = indexPath.row;
    cell.closeDebtButtonAction.tag = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 215;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DebtsDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DebtsDetailViewController"];
    controller.debtStatus = DebtStatusEdit;
    controller.selectedDebt = self.debtsArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
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
    
    Debt *currentDebt = self.debtsArray[sourceIndexPath.row];
    [self.debtsArray removeObjectAtIndex:sourceIndexPath.row];
    [self.debtsArray insertObject:currentDebt atIndex:destinationIndexPath.row];
    
    int i = 1;
    for (Debt *item in self.debtsArray) {
        item.debtSort = i++;
    }
    
    [[CoreDataAccessLayer sharedInstance] saveContext];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
        NSError *error = nil;
        [context deleteObject:self.debtsArray[indexPath.row]];
        if (![context save:&error]) {
            NSLog(@"Can't delete: %@",[error localizedDescription]);
        }
        [self reloadDataForIndex:DebtsSortByCreationDateNewest];
    }
}

#pragma mark - DebtsTableViewCellDelegate

- (void)transactionsButtonDebtsCell:(NSInteger)buttonTag {
    
    DebtsTransactionsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DebtsTransactionsViewController"];
    controller.transactionsArray = [self.debtsArray[buttonTag].transactions allObjects];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)closeDebtButtonDebtsCell:(NSInteger)buttonTag {
    
    self.selectedDebtForClose = buttonTag;
    [self showSortActionSheet:@[@"Full",@"Partial"]
                    withTitle:@"Are you sure you want to close this debt? New payback record will be generated."
                 andActionTag:ActionSheetTypeCloseDebt];
}

@end
