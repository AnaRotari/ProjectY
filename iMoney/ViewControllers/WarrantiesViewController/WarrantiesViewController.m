//
//  WarrantiesViewController.m
//  iMoney
//
//  Created by Alex on 4/15/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "WarrantiesViewController.h"
#import "TransactionDetailViewController.h"
#import "MRAlertView.h"

typedef NS_ENUM(NSInteger, SheetType){
    SheetTypeLenght = 10,
    SheetTypeWallet = 20,
    SheetTypeWalletIncomeExpense = 30,
    SheetTypeSorting = 40
};

@interface WarrantiesViewController () <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, MRAlertViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray <Transaction *> *transactionsArray;
@property (strong, nonatomic) NSArray <Wallet *> *walletsArray;

@property (strong, nonatomic) Wallet *selectedWallet;
@property (strong, nonatomic) NSString *selectedWarrientyLength;
@property (strong, nonatomic) NSString *selectedWarrientyType;
@property (strong, nonatomic) NSString *insertedAmount;

@end

@implementation WarrantiesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpNavigationControllerButtons];
    [self basicInit];
}

- (void)basicInit {
    
    [self setupWarrientiesTableView];
    self.walletsArray = [CoreDataRequestManager getAllWallets];
}

- (void)setupWarrientiesTableView {
    
    [self.warrantiesTableView registerNib:[UINib nibWithNibName:@"WarrantiesTableViewCell" bundle:nil] forCellReuseIdentifier:@"WarrantiesTableViewCell"];
    self.warrantiesTableView.tableFooterView = [UIView new];
    [self reloadContent:WarrantieSortOptionByCreationDateNewest];
}

- (void)setUpNavigationControllerButtons {
    
    self.title = @"Warranties";
    UIBarButtonItem *addWarrientyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                        target:self
                                                                                        action:@selector(addWarrientyButtonAction)];
    
    UIBarButtonItem *sortButton = [iMoneyUtils getNavigationButton:@"ic_sort"
                                                            target:self
                                                       andSelector:@selector(sortButtonAction)];
    
    self.navigationItem.rightBarButtonItems = @[addWarrientyButton, sortButton];
}

- (void)reloadContent:(WarrantiesSortOptions)option {
    
    self.transactionsArray = [[CoreDataRequestManager getAllTransactionsWithWarrienty:option] mutableCopy];
    self.transactionsArray.count ? [self.listIsEmptyLabel setHidden:YES] : [self.listIsEmptyLabel setHidden:NO];
    [self.warrantiesTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                            withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Buttons actions

- (void)addWarrientyButtonAction {
    
    [self showSortSheet:@[@"12 month's warranty",@"24 month's warranty"]
               withName:@"Select warrienty length"
                 andTag:SheetTypeLenght];
}

- (void)sortButtonAction {
    
    NSArray *sortOptions = @[@"By creation date - newest",
                             @"By creation date - oldest",
                             @"By amount - highest",
                             @"By amount - lowest",
                             @"By due date - newest",
                             @"By due date - oldest"];
    
    [self showSortSheet:sortOptions
               withName:@"Sorting"
                 andTag:SheetTypeSorting];
}

- (void)showSortSheet:(NSArray <NSString *> *)dataArray withName:(NSString *)name andTag:(NSInteger)sheetTag {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = name;
    actionSheet.delegate = self;
    actionSheet.tag = sheetTag;
    
    for (NSString *option in dataArray) {
        
        [actionSheet addButtonWithTitle:option];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView: self.view];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.transactionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WarrantiesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WarrantiesTableViewCell" forIndexPath:indexPath];
    [cell setupCellWithTransactionDetails:self.transactionsArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TransactionDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TransactionDetailViewController"];
    controller.transactionDetail = self.transactionsArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Transaction *deletedTransaction = self.transactionsArray[indexPath.row];
        Wallet *transactionWallet = deletedTransaction.wallet;
        
        switch (deletedTransaction.transactionType) {
                
            case kTransactionTypeIncome:
                transactionWallet.walletBalance = [transactionWallet.walletBalance decimalNumberBySubtracting:deletedTransaction.transactionAmount];
                break;
            case kTransactionTypeExpense:
                transactionWallet.walletBalance = [transactionWallet.walletBalance decimalNumberByAdding:deletedTransaction.transactionAmount];
                break;
                
            default:
                break;
        }
        
        NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
        NSError *error = nil;
        
        [context deleteObject:deletedTransaction];
        
        if (![context save:&error]) {
            NSLog(@"Can't delete: %@",[error localizedDescription]);
        }
        
        [self.transactionsArray removeObjectAtIndex:indexPath.row];
        self.transactionsArray.count ? [self.listIsEmptyLabel setHidden:YES] : [self.listIsEmptyLabel setHidden:NO];
        [self.warrantiesTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        if (actionSheet.tag == SheetTypeLenght)
        {
            if (buttonIndex == 0)
            {
                self.selectedWarrientyLength = @"12 month's warranty";
            }
            if (buttonIndex == 1)
            {
                self.selectedWarrientyLength = @"24 month's warranty";
            }
            [self selectWallet];
        }
        if (actionSheet.tag == SheetTypeWallet)
        {
            self.selectedWallet = self.walletsArray[buttonIndex];
            [self seletTransactionType];
        }
        if (actionSheet.tag == SheetTypeWalletIncomeExpense)
        {
            if (buttonIndex == 0)
            {
                self.selectedWarrientyType = @"Expense";
            }
            if (buttonIndex == 1)
            {
                self.selectedWarrientyType = @"Income";
            }
            [self showInputAmountView];
        }
        if (actionSheet.tag == SheetTypeSorting)
        {
            [self reloadContent:buttonIndex];
        }
    }
}

- (void)showInputAmountView {
    
    MRAlertView *alertView = [[MRAlertView alloc] initWithTitle:@"Amount"
                                                        message:@"Enter value"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Ok"];
    [alertView setAlertViewStyle:MRAlertViewStylePlainTextInput];
    [alertView show];
}

#pragma mark - MRAlertViewDelegate

- (void)alertView:(MRAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1)
    {
        if ([alertView.textView.text length] > 0)
        {
            self.insertedAmount = alertView.textView.text;
            [self insertWarrientyInfoToDatabase];
        }
    }
}

- (void)selectWallet {
    
    NSMutableArray <NSString *> *walletsName = [[NSMutableArray alloc] init];
    for (Wallet *wallet in self.walletsArray) {
        [walletsName addObject:wallet.walletName];
    }
    
    [self showSortSheet:walletsName
               withName:@"Select wallet"
                 andTag:SheetTypeWallet];
}

- (void)seletTransactionType {
    
    [self showSortSheet:@[@"Expense",@"Income"]
               withName:@"Select transaction type"
                 andTag:SheetTypeWalletIncomeExpense];
}

- (void)insertWarrientyInfoToDatabase {
    
    [CoreDataInsertManager createWarrientyTransaction:@{@"WarrientyLength" : self.selectedWarrientyLength,
                                                        @"WarrientyType"   : self.selectedWarrientyType,
                                                        @"WarrientyAmount" : self.insertedAmount}
                                             toWallet:self.selectedWallet];
    [self reloadContent:WarrantieSortOptionByCreationDateNewest];
}

@end
