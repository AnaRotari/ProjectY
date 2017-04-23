//
//  BudgetsDetailViewController.m
//  iMoney
//
//  Created by Alex on 4/23/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BudgetsDetailViewController.h"
#import "TransactionTableViewCell.h"
#import "TransactionDetailViewController.h"

@interface BudgetsDetailViewController ()

@property (strong, nonatomic) NSArray <Transaction *> *budgetTransactions;

@end

@implementation BudgetsDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Budget detail";
    [self basicSetup];
}

- (void)basicSetup {
    
    [self.budgetTransactionTableView registerNib:[UINib nibWithNibName:@"TransactionTableViewCell" bundle:nil] forCellReuseIdentifier:@"TransactionTableViewCell"];
    self.budgetTransactionTableView.tableFooterView = [UIView new];
    self.budgetTransactions = [self.selectedBudget.transactions allObjects];
    self.noTransactionLabel.hidden = self.budgetTransactions.count;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.budgetTransactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionTableViewCell" forIndexPath:indexPath];
    [cell initTransactionCell:self.budgetTransactions[indexPath.row] hidesDateLabel:NO];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TransactionDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TransactionDetailViewController"];
    controller.transactionDetail = self.budgetTransactions[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

@end
