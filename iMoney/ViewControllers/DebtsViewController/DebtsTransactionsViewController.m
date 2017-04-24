//
//  DebtsTransactionsViewController.m
//  iMoney
//
//  Created by Alex on 4/24/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "DebtsTransactionsViewController.h"
#import "TransactionDetailViewController.h"
#import "TransactionTableViewCell.h"

@interface DebtsTransactionsViewController ()

@end

@implementation DebtsTransactionsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupDebtsTableView];
}

- (void)setupDebtsTableView {
    
    [self.debtTransactionsTableView registerNib:[UINib nibWithNibName:@"TransactionTableViewCell" bundle:nil] forCellReuseIdentifier:@"TransactionTableViewCell"];
    self.debtTransactionsTableView.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.transactionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionTableViewCell" forIndexPath:indexPath];
    [cell initTransactionCell:self.transactionsArray[indexPath.row] hidesDateLabel:NO];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TransactionDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TransactionDetailViewController"];
    controller.transactionDetail = self.transactionsArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
