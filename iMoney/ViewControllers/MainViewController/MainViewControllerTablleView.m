//
//  MainViewControllerTablleView.m
//  iMoney
//
//  Created by Alex on 3/21/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MainViewControllerTablleView.h"
#import "TransactionTableViewCell.h"

@implementation MainViewControllerTablleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transactionsArray = [NSArray array];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.transactionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionTableViewCell" forIndexPath:indexPath];
    [cell initTransactionCell:self.transactionsArray[indexPath.row] hidesDateLabel:YES];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

@end
