//
//  RecordsViewController.m
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "RecordsViewController.h"

@interface RecordsViewController () <MKDropdownMenuDelegate,MKDropdownMenuDataSource>

@property (strong, nonatomic) NSArray <Wallet *> *walletsArray;
@property (strong, nonatomic) NSArray <Transaction *> *transactionsArray;

@end

@implementation RecordsViewController{
    NSString *walletName;
    NSInteger selectedWalletIndex, selectedYear, selectedMonthIndex;
    __weak IBOutlet UILabel *noTransactionsLabel;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self registerCells];
    
    walletName = @"All wallets";
    selectedWalletIndex = -1;
    _walletsArray = [CoreDataRequestManager getAllWallets];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    selectedMonthIndex = components.month-1;
    selectedYear = components.year;

    [self reloadContentForWallet:selectedWalletIndex];
    
    [self.walletsDropDownMenu setDropdownCornerRadius:5];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(moveToCurrentDate:)];
    self.navigationItem.rightBarButtonItem = button;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_recordsSwitcherCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:selectedMonthIndex inSection:0]
                                                 animated:false
                                           scrollPosition:UICollectionViewScrollPositionLeft];
}

-(void)moveToCurrentDate:(UIBarButtonItem *)sender{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    selectedMonthIndex = components.month-1;
    selectedYear = components.year;
    
    [_recordsSwitcherCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:selectedMonthIndex inSection:0]
                                                 animated:true
                                           scrollPosition:UICollectionViewScrollPositionLeft];
    [self reloadContentForWallet:selectedWalletIndex];
}

- (void)registerCells {
    [self.recordsVisualiserTableView registerNib:[UINib nibWithNibName:@"RecordsTableViewCell" bundle:nil] forCellReuseIdentifier:@"RecordsTableViewCell"];
    [self.recordsSwitcherCollectionView registerNib:[UINib nibWithNibName:@"RecordsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RecordsCollectionViewCell"];
    [_recordsVisualiserTableView setTableFooterView:[UIView new]];
}

#pragma mark - data manipulation

-(void)reloadContentForWallet:(NSInteger)walletIndex{
    NSArray<Transaction*> *transactions;
    if (walletIndex == -1) {
        transactions = [CoreDataRequestManager getAllTransactions];
    }else{
        Wallet *wallet = _walletsArray[walletIndex];
        transactions = [CoreDataRequestManager getAllTransactionForWallet:wallet];
    }
    _transactionsArray = [self sortedTransactionsByMonth:transactions];
    
    [_recordsVisualiserTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [_recordsSwitcherCollectionView reloadData];
    if (_transactionsArray.count > 0) {
        [_recordsVisualiserTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                           atScrollPosition:UITableViewScrollPositionTop
                                                   animated:false];
    }
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
    
    return _walletsArray.count+1;
}

#pragma mark - MKDropdownMenuDelegate

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component {
    return walletName;
}

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row == 0) {
        return @"All wallets";
    }
    return _walletsArray[row-1].walletName;
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == 0) {
        walletName = @"All wallets";
    }else
        walletName = _walletsArray[row-1].walletName;
    
    selectedWalletIndex = row - 1;
    
    [dropdownMenu closeAllComponentsAnimated:YES];
    [dropdownMenu reloadComponent:component];
    [self reloadContentForWallet:selectedWalletIndex];
    
//    self.selectedTransactionTypeLabel.text = self.transactionTypeArray[row];
//    selectedTransactionType = row;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _transactionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordsTableViewCell" forIndexPath:indexPath];
    [cell setTransaction:_transactionsArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TransactionDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TransactionDetailViewController"];
    controller.transactionDetail = self.transactionsArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 12;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecordsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecordsCollectionViewCell" forIndexPath:indexPath];
    
    cell.balancePeriodLabel.text = [self formatedDate:indexPath.row];
    cell.cashflowLabel.text = [self cashflowString];
    
    cell.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate

//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    
//    if(scrollView == self.recordsSwitcherCollectionView)
//    {
//        self.selectedMonthIndex = targetContentOffset->x/CGRectGetWidth(self.recordsSwitcherCollectionView.frame);
//        [self reloadContentForWallet:selectedWalletIndex];
//    }
//}

#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

#pragma mark - RecordsCollectionViewCellDelegate

- (void)collectionNextButtonPushed {
    selectedMonthIndex ++;
    
    if ((selectedMonthIndex+1)%13 == 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.recordsSwitcherCollectionView selectItemAtIndexPath:indexPath animated:true scrollPosition:UICollectionViewScrollPositionLeft];
        selectedMonthIndex = 0;
        selectedYear++;
    }else
        [self.recordsSwitcherCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:selectedMonthIndex inSection:0]
                                                         animated:true
                                                   scrollPosition:UICollectionViewScrollPositionRight];

    [self reloadContentForWallet:selectedWalletIndex];
}

- (void)collectionPreviousButtonPushed {
    
    selectedMonthIndex --;
    
    if (selectedMonthIndex == -1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:11 inSection:0];
        [self.recordsSwitcherCollectionView selectItemAtIndexPath:indexPath animated:true scrollPosition:UICollectionViewScrollPositionLeft];
        selectedMonthIndex = 11;
        selectedYear--;
    }else
        [self.recordsSwitcherCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:selectedMonthIndex inSection:0]
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
    for (Transaction *transaction in _transactionsArray) {
        if (transaction.transactionType == kTransactionTypeIncome) {
            total += transaction.transactionAmount.floatValue;
        }else if(transaction.transactionType == kTransactionTypeExpense){
            total -= transaction.transactionAmount.floatValue;
        }
    }
    return total;
}

-(NSString *)cashflowString{
    if (selectedWalletIndex == -1 || _transactionsArray.count == 0) {return @"";}
    
    NSString *currency = _walletsArray[selectedWalletIndex].walletCurrency;
    NSString *sign = [self cashflow] > 0 ? @"+" : @"-";
    return [NSString stringWithFormat:@"Cashflow: %@%@ %.2f", sign, currency, [self cashflow]];
}
@end
