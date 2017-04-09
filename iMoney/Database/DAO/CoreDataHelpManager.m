//
//  CoreDataHelpManager.m
//  iMoney
//
//  Created by Alex on 4/9/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "CoreDataHelpManager.h"

@implementation CoreDataHelpManager

+ (void)transferTransaction:(Transaction *)transaction
           fromSourceWallet:(Wallet *)sourceWallet
        toDestinationWallet:(Wallet *)destinationWaller {
    
    [destinationWaller addTransactionsObject:transaction];
    
    switch (transaction.transactionType) {
        case kTransactionTypeIncome:
            
            destinationWaller.walletBalance = [destinationWaller.walletBalance decimalNumberByAdding:transaction.transactionAmount];
            
            sourceWallet.walletBalance = [sourceWallet.walletBalance decimalNumberBySubtracting:transaction.transactionAmount];
            
            break;
        case kTransactionTypeExpense:
            
            destinationWaller.walletBalance = [destinationWaller.walletBalance decimalNumberBySubtracting:transaction.transactionAmount];
            sourceWallet.walletBalance = [sourceWallet.walletBalance decimalNumberByAdding:transaction.transactionAmount];
            
            break;
            
        default:
            break;
    }
    
    [[CoreDataAccessLayer sharedInstance] saveContext];
}

@end
