//
//  CreateBudgetViewController.m
//  iMoney
//
//  Created by Alex on 4/23/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "CreateBudgetViewController.h"
@interface CreateBudgetViewController ()

@property (strong, nonatomic) NSArray *budgetIntervalArray;
@property (assign, nonatomic) NSInteger selectedInterval;

@property (strong, nonatomic) NSArray <Wallet *> *walletsArray;
@property (strong, nonatomic) NSMutableArray <NSNumber *> *selectionArray;

@end

@implementation CreateBudgetViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self basicInit];
    [self setupNavigationBar];
}

- (void)basicInit {
    
    self.title = @"Create budget";
    self.budgetIntervalArray = @[@"Weekly",@"Monthly",@"Yearly"];
    self.selectedPeriodLabel.text = self.budgetIntervalArray[self.selectedInterval];
    self.selectedPeriodLabel.layer.borderColor = RGBColor(42, 3, 70, 1).CGColor;
    self.selectedPeriodLabel.layer.borderWidth = 1;
    self.walletsArray = [CoreDataRequestManager getAllWallets];
    
    self.selectionArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.walletsArray.count; i++) {
        [self.selectionArray addObject:@(0)];
    }
    
    [self.walletsTableView registerNib:[UINib nibWithNibName:@"BudgetWalletTableViewCell" bundle:nil] forCellReuseIdentifier:@"BudgetWalletTableViewCell"];
    self.walletsTableView.tableFooterView = [UIView new];
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *doneButton = [iMoneyUtils getNavigationButton:@"ic_checkmark"
                                                            target:self
                                                       andSelector:@selector(doneButtonAction)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (IBAction)selectPeriodButtonAction:(id)sender {
    
    [self showSortActionSheet:self.budgetIntervalArray];
}

- (void)doneButtonAction {

    NSMutableSet <Wallet *> *selectedWallets = [[NSMutableSet alloc] init];
    
    for (int i = 0 ; i < self.selectionArray.count; i++) {
        
        if ([self.selectionArray[i] isEqual:@(1)]) {
            [selectedWallets addObject:self.walletsArray[i]];
        }
    }
    
    if ([self checkAllNeccessaryFields])
    {
        if ([self checkIfCurrencyIsDifferent:selectedWallets]) {
            
            NSDate *finishDate = [iMoneyUtils getTodayFormatedDate];
            
            switch (self.selectedInterval) {
                    
                case BudgetIntervalWeekly:
                    finishDate = [[iMoneyUtils getTodayFormatedDate] dateByAddingTimeInterval: 7 * 24 * 60 * 60];
                    break;
                case BudgetIntervalMonthly:
                    finishDate = [[iMoneyUtils getTodayFormatedDate] dateByAddingTimeInterval: 31 * 24 * 60 * 60];
                    break;
                case BudgetIntervalYearly:
                    finishDate = [[iMoneyUtils getTodayFormatedDate] dateByAddingTimeInterval: 365 * 24 * 60 * 60];
                    break;
                    
                default:
                    break;
            }
            
            NSDictionary *options = @{@"budgetName"        : self.budgetNameTextfield.text,
                                      @"budgetTotalAmount" : self.budgetAmountTextField.text,
                                      @"budgetStartDate"   : [iMoneyUtils getTodayFormatedDate],
                                      @"budgetFinishDate"  : finishDate,
                                      @"budgetInterval"    : @(self.selectedInterval),
                                      @"wallets"           : selectedWallets};
            
            [CoreDataBudgetManager createBudgetWithOptions:options];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            
            [iMoneyUtils showAlertView:@"Alert"
                           withMessage:@"The walets have to have the same currency !"];
        }
    }
    else
    {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"Please fill-up all fields !"];
    }
}

- (BOOL)checkIfCurrencyIsDifferent:(NSMutableSet <Wallet *> *)setToCheck {
    
    NSMutableArray <NSString *> *currenciesArray = [[NSMutableArray alloc] init];
    
    for (Wallet *wallet in setToCheck) {
        [currenciesArray addObject:wallet.walletCurrency];
    }
    
    NSString *currencyIopt = currenciesArray[0];
    
    for (NSString *allCurrencies in currenciesArray) {
        if (![currencyIopt isEqualToString:allCurrencies]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)checkAllNeccessaryFields {
    
    NSMutableSet <Wallet *> *selectedWallets = [[NSMutableSet alloc] init];
    
    for (int i = 0 ; i < self.selectionArray.count; i++) {
        
        if ([self.selectionArray[i] isEqual:@(1)]) {
            [selectedWallets addObject:self.walletsArray[i]];
        }
    }
    
    if (self.budgetNameTextfield.text.length > 0 && self.budgetAmountTextField.text.length > 0 && selectedWallets.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.walletsTableView]) {
        [self.view endEditing:YES];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)showSortActionSheet:(NSArray <NSString *> *)sortOptionsArray {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"Select period";
    actionSheet.delegate = self;
    
    for (NSString *option in sortOptionsArray) {
        
        [actionSheet addButtonWithTitle:option];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView: self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        
        self.selectedInterval = buttonIndex;
        self.selectedPeriodLabel.text = self.budgetIntervalArray[buttonIndex];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.walletsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BudgetWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BudgetWalletTableViewCell" forIndexPath:indexPath];
    cell.walletNameLabel.text = self.walletsArray[indexPath.row].walletName;
    cell.walletCurrencyLabel.text = self.walletsArray[indexPath.row].walletCurrency;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BudgetWalletTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.selectionArray[indexPath.row] = @(0);
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectionArray[indexPath.row] = @(1);
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

@end
