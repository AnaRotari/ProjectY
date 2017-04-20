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

@property (assign, nonatomic) NSInteger selectedMonth;

@end

@implementation RecordsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self registerCells];
    
    [self.walletsDropDownMenu setDropdownCornerRadius:5];
}

- (void)registerCells {
    
    [self.recordsVisualiserTableView registerNib:[UINib nibWithNibName:@"RecordsTableViewCell" bundle:nil] forCellReuseIdentifier:@"RecordsTableViewCell"];
    [self.recordsSwitcherCollectionView registerNib:[UINib nibWithNibName:@"RecordsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RecordsCollectionViewCell"];
}

#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    
    return 2;
}

#pragma mark - MKDropdownMenuDelegate

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component {
    
    return @"Wallet Wallet";
}

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return @"1111";
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [dropdownMenu closeAllComponentsAnimated:YES];
//    self.selectedTransactionTypeLabel.text = self.transactionTypeArray[row];
//    selectedTransactionType = row;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordsTableViewCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
#warning DECOMENT WHEN IMPLEMENT LOGIC
//    TransactionDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TransactionDetailViewController"];
//    controller.transactionDetail = self.transactionsArray[indexPath.row];
//    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RecordsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecordsCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if(scrollView == self.recordsSwitcherCollectionView)
    {
        self.selectedMonth = targetContentOffset->x/CGRectGetWidth(self.recordsSwitcherCollectionView.frame);
//        [self reloadContent];
    }
}

#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

- (void)viewDidLayoutSubviews{
    [self.recordsSwitcherCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedMonth inSection:0]
                                      atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    [self.recordsSwitcherCollectionView reloadData];
}

#pragma mark - RecordsCollectionViewCellDelegate

- (void)collectionNextButtonPushed {
    
    self.selectedMonth ++;
//    [self reloadContent];
    [self.recordsSwitcherCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedMonth inSection:0]
                                      atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)collectionPreviousButtonPushed {
    
    self.selectedMonth --;
    //    [self reloadContent];
    [self.recordsSwitcherCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedMonth inSection:0]
                                               atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

@end
