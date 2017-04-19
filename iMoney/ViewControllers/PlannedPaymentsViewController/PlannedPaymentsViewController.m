//
//  PlannedPaymentsViewController.m
//  iMoney
//
//  Created by Alex on 4/17/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "PlannedPaymentsViewController.h"

@interface PlannedPaymentsViewController ()

@property (strong, nonatomic) NSMutableArray <PlannedPayments *> *plannedArray;

@end

@implementation PlannedPaymentsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpNavigationControllerButtons];
    [self prepareTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self reloadDataForIndex:PlannedPaymentsSortByCreationDateNewest];
}

- (void)prepareTableView {
    
    [self.plannedPaymentsTableView registerNib:[UINib nibWithNibName:@"PlannedPaymentsTableViewCell" bundle:nil] forCellReuseIdentifier:@"PlannedPaymentsTableViewCell"];
    self.plannedPaymentsTableView.tableFooterView = [UIView new];
}

- (void)setUpNavigationControllerButtons {
    
    self.title = @"Planned payments";
    UIBarButtonItem *addWarrientyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                        target:self
                                                                                        action:@selector(addPlannedPaymentButtonAction)];
    
    UIBarButtonItem *editPaymentsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                        target:self
                                                                                        action:@selector(editPlannedPaymentsButtonAction)];
    
    UIBarButtonItem *sortButton = [iMoneyUtils getNavigationButton:@"ic_sort"
                                                            target:self
                                                       andSelector:@selector(sortButtonAction)];
    
    self.navigationItem.rightBarButtonItems = @[addWarrientyButton, sortButton, editPaymentsButton];
}

#pragma mark - Button actions

- (void)addPlannedPaymentButtonAction {
    
    PlannedPayments *plannedPayment = [NSEntityDescription insertNewObjectForEntityForName:@"PlannedPayments"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    
    PlannedPaymentsCreatorViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PlannedPaymentsCreatorViewController"];
    controller.plannedPayment = plannedPayment;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)sortButtonAction {
    
    [self showSortActionSheet:@[@"By creation date - newest",
                                @"By creation date - oldest",
                                @"By name - A->Z",
                                @"By name - Z->A",
                                @"By amount - Ascending",
                                @"By amount - Descending"]];
}

- (void)editPlannedPaymentsButtonAction {
    
    self.plannedPaymentsTableView.isEditing ? [self.plannedPaymentsTableView setEditing:NO animated:YES] : [self.plannedPaymentsTableView setEditing:YES animated:YES];
}

-(void)reloadDataForIndex:(NSInteger)index {
    
    self.plannedArray = [CoreDataPlannedPaymentsManager getAllPlannedPayments:index];
    self.plannedArray.count ? [self.plannedListLabel setHidden:YES] : [self.plannedListLabel setHidden:NO];
    [self.plannedPaymentsTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                 withRowAnimation:UITableViewRowAnimationFade];
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
    
    return self.plannedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlannedPaymentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlannedPaymentsTableViewCell" forIndexPath:indexPath];
    [cell initCellWithPayment:self.plannedArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlannedPaymentsCreatorViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PlannedPaymentsCreatorViewController"];
    controller.plannedPayment = self.plannedArray[indexPath.row];
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
    
    PlannedPayments *plannedPayment = self.plannedArray[sourceIndexPath.row];
    
    [self.plannedArray removeObjectAtIndex:sourceIndexPath.row];
    [self.plannedArray insertObject:plannedPayment atIndex:destinationIndexPath.row];
    
    int i = 1;
    for (PlannedPayments *item in self.plannedArray) {
        item.plannedSort = i++;
    }
    
    [[CoreDataAccessLayer sharedInstance] saveContext];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //        Transaction *deletedTransaction = self.transactionsArray[indexPath.row];
        //        Wallet *transactionWallet = deletedTransaction.wallet;
        //
        //        switch (deletedTransaction.transactionType) {
        //
        //            case kTransactionTypeIncome:
        //                transactionWallet.walletBalance = [transactionWallet.walletBalance decimalNumberBySubtracting:deletedTransaction.transactionAmount];
        //                break;
        //            case kTransactionTypeExpense:
        //                transactionWallet.walletBalance = [transactionWallet.walletBalance decimalNumberByAdding:deletedTransaction.transactionAmount];
        //                break;
        //
        //            default:
        //                break;
        //        }
        
        NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
        NSError *error = nil;
        
        [context deleteObject:self.plannedArray[indexPath.row]];
        
        if (![context save:&error]) {
            NSLog(@"Can't delete: %@",[error localizedDescription]);
        }
        
        [self.plannedArray removeObjectAtIndex:indexPath.row];
        self.plannedArray.count ? [self.plannedListLabel setHidden:YES] : [self.plannedListLabel setHidden:NO];
        [self.plannedPaymentsTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                     withRowAnimation:UITableViewRowAnimationFade];
    }
}



@end
