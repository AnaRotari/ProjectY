//
//  ReportsViewController.m
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ReportsViewController.h"

@interface ReportsViewController ()

@end

@implementation ReportsViewController{
    NSString *walletName;
    NSInteger selectedWalletIndex, selectedYear, selectedMonthIndex;
    
    NSArray <Wallet *> *walletsArray;
    NSArray <Transaction *> *transactionsArray;
    
    //UI
    __weak IBOutlet UILabel *noTransactionsLabel;
    __weak IBOutlet UIView *supportView;
    //Income
    __weak IBOutlet UILabel *incomeCountLabel;
    __weak IBOutlet UILabel *incomeAverageDayLabel;
    __weak IBOutlet UILabel *incomeAverageRecordLabel;
    __weak IBOutlet UILabel *incomeTotalLabel;
    //Expense
    __weak IBOutlet UILabel *expenseCountLabel;
    __weak IBOutlet UILabel *expenseAverageDayLabel;
    __weak IBOutlet UILabel *expenseAverageRecordLabel;
    __weak IBOutlet UILabel *expenseTotalLabel;
    //Bottom
    __weak IBOutlet UILabel *startingBalanceLabel;
    __weak IBOutlet UILabel *netEndingBalanceLabel;
    __weak IBOutlet UILabel *cashflowLabel;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self registerReportsCollectionViewCell];
    
    walletsArray = [CoreDataRequestManager getAllWallets];
    selectedWalletIndex = 0;
    if (walletsArray.count == 0) {
        walletName = @"No wallets added";
    }else
        walletName = walletsArray[selectedWalletIndex].walletName;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    selectedMonthIndex = components.month-1;
    selectedYear = components.year;
    
    [self reloadContentForWallet:selectedWalletIndex];
    
    [self.walletsDropDownMenu setDropdownCornerRadius:5];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(moveToCurrentDate:)];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)registerReportsCollectionViewCell {
    
    [self.reportsCollectionView registerNib:[UINib nibWithNibName:@"ReportsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ReportsCollectionViewCell"];
    self.reportsCollectionView.contentOffset = CGPointMake(0, 0);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_reportsCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:selectedMonthIndex inSection:0]
                                                 animated:false
                                           scrollPosition:UICollectionViewScrollPositionLeft];
}

-(void)moveToCurrentDate:(UIBarButtonItem *)sender{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    selectedMonthIndex = components.month-1;
    selectedYear = components.year;
    
    [_reportsCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:selectedMonthIndex inSection:0]
                                                 animated:true
                                           scrollPosition:UICollectionViewScrollPositionLeft];
    [self reloadContentForWallet:selectedWalletIndex];
}

#pragma mark - data manipulation

-(void)reloadContentForWallet:(NSInteger)walletIndex{
    if (walletsArray.count == 0) {return;}
    
    NSArray<Transaction*> *transactions;
    Wallet *wallet = walletsArray[walletIndex];
    transactions = [CoreDataRequestManager getAllTransactionForWallet:wallet];
    
    transactionsArray = [self sortedTransactionsByMonth:transactions];
    
    [_reportsCollectionView reloadData];
}

-(NSArray *)sortedTransactionsByMonth:(NSArray<Transaction*> *)array{
    NSMutableArray<Transaction *> *result = [NSMutableArray array];
    
    for (Transaction *transaction in array) {
        NSDate *date = transaction.transactionDate;
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        if (components.month == selectedMonthIndex+1 && components.year == selectedYear) {
            [result addObject:transaction];
        }
    }
    [noTransactionsLabel setHidden:result.count];
    return result;
}

#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    
    return walletsArray.count;
}

#pragma mark - MKDropdownMenuDelegate

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component {
    return walletName;
}

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return walletsArray[row].walletName;
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    walletName = walletsArray[row].walletName;
    selectedWalletIndex = row;
    
    [dropdownMenu closeAllComponentsAnimated:YES];
    [dropdownMenu reloadComponent:component];
    [self reloadContentForWallet:selectedWalletIndex];
}

#pragma mark - UICollectionViewDataSource 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 12;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ReportsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReportsCollectionViewCell" forIndexPath:indexPath];
    [cell setDelegate:self];
    
    cell.currentMonthLabel.text = [self formatedDate:indexPath.row];
    cell.cashflowLabelTop.text = [self cashflowString];
    
    [cell setTransaction:transactionsArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - RecordsCollectionViewCellDelegate

- (void)collectionNextButtonPushed {
    selectedMonthIndex ++;
    
    if ((selectedMonthIndex+1)%13 == 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_reportsCollectionView selectItemAtIndexPath:indexPath animated:true scrollPosition:UICollectionViewScrollPositionLeft];
        selectedMonthIndex = 0;
        selectedYear++;
    }else
        [_reportsCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:selectedMonthIndex inSection:0]
                                                         animated:true
                                                   scrollPosition:UICollectionViewScrollPositionRight];
    
    [self reloadContentForWallet:selectedWalletIndex];
}

- (void)collectionPreviousButtonPushed {
    
    selectedMonthIndex --;
    
    if (selectedMonthIndex == -1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:11 inSection:0];
        [_reportsCollectionView selectItemAtIndexPath:indexPath animated:true scrollPosition:UICollectionViewScrollPositionLeft];
        selectedMonthIndex = 11;
        selectedYear--;
    }else
        [_reportsCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:selectedMonthIndex inSection:0]
                                                         animated:true
                                                   scrollPosition:UICollectionViewScrollPositionLeft];
    [self reloadContentForWallet:selectedWalletIndex];
}

#pragma mark - others
-(NSString *)formatedDate:(NSInteger)month{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [components setMonth:month+1];
    [components setYear:selectedYear];
    
    NSDate *date = [calendar dateFromComponents:components];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    NSString *dateComponents = @"MMMMyyyy";
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:dateComponents options:0 locale:[NSLocale currentLocale]];
    [formater setDateFormat:dateFormat];
    
    NSString *dateString = [formater stringFromDate:date];
    return dateString;
}

-(float)cashflow{
    float total = 0;
    for (Transaction *transaction in transactionsArray) {
        if (transaction.transactionType == kTransactionTypeIncome) {
            total += transaction.transactionAmount.floatValue;
        }else if(transaction.transactionType == kTransactionTypeExpense){
            total -= transaction.transactionAmount.floatValue;
        }
    }
    return total;
}

-(NSString *)cashflowString{
    if (selectedWalletIndex == -1 || transactionsArray.count == 0) {return @"";}
    
    NSString *currency = walletsArray[selectedWalletIndex].walletCurrency;
    NSString *sign = [self cashflow] > 0 ? @"+" : @"-";
    return [NSString stringWithFormat:@"Cashflow: %@%@ %.2f", sign, currency, [self cashflow]];
}
@end
