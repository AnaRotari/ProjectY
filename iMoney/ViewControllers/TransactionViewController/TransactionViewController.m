//
//  TransactionViewController.m
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "TransactionViewController.h"

@interface TransactionViewController ()

@end

@implementation TransactionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    [iMoneyUtils setStatusBarBackgroundColor:[[UIColor alloc] colorWithData:self.parentWallet.walletColor]
                     forNavigationController:self.navigationController];
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *doneNavButton = [iMoneyUtils getNavigationButton:@"ic_checkmark"
                                                               target:self
                                                          andSelector:@selector(doneButtonAction:)];
    self.navigationItem.rightBarButtonItems = @[doneNavButton];
}

- (void)doneButtonAction:(id)sender {
    
    [self constructTransaction];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)constructTransaction {
   
    NSDictionary *finalTransactionsDetails = @{kTransactionAmount      : @"",
                                               kTransactionAttachemts  : @"",
                                               kTransactionCategory    : @"",
                                               kTransactionDate        : [iMoneyUtils getTodayFormatedDate],
                                               kTransactionDescription : @"",
                                               kTransactionPayee       : @"",
                                               kTransactionPaymentType : @"",
                                               kTransactionType        : @""};
    
    [CoreDataInsertManager createTransaction:finalTransactionsDetails
                                    toWallet:self.parentWallet];
}

@end
