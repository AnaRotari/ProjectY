//
//  CoreDataInsertManager.m
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "CoreDataInsertManager.h"

@implementation CoreDataInsertManager

+ (void)createWallet:(NSDictionary *)walletValues {
    
    NSError *error = nil;
    NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
    UIColor *walletColor = walletValues[kWalletColor];
    Wallet *lastWallet = [[CoreDataRequestManager getAllWallets] lastObject];
    
    Wallet *wallet = [NSEntityDescription insertNewObjectForEntityForName:@"Wallet"
                                                   inManagedObjectContext:context];
    wallet.walletID = [wallet.objectID URIRepresentation].absoluteString;
    wallet.walletCurrency = walletValues[kWalletCurrency];
    wallet.walletDescription = walletValues[kWalletDescription];
    wallet.walletBalance = [[NSDecimalNumber alloc] initWithString:walletValues[kWalletBalance]];
    wallet.walletName = walletValues[kWalletName];
    wallet.walletColor = walletColor.encode;
    wallet.walletSort = lastWallet.walletSort + 1;
    
    if(![context save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    } else {
        NSLog(@"successfull saved");
    }
}

+ (void)createTransaction:(NSDictionary *)transactionDetails toWallet:(Wallet *)wallet {
    
    NSError *error = nil;
    NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
    
    Transaction *newTransaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction"
                                                                inManagedObjectContext:context];
    
    newTransaction.transactionAmount      = [[NSDecimalNumber alloc] initWithString:transactionDetails[kTransactionAmount]];
    newTransaction.transactionCategory    = [transactionDetails[kTransactionCategory] intValue];
    newTransaction.transactionDate        = transactionDetails[kTransactionDate];
    newTransaction.transactionDescription = transactionDetails[kTransactionDescription];
    newTransaction.transactionPayee       = transactionDetails[kTransactionPayee];
    newTransaction.transactionPaymentType = [transactionDetails[kTransactionPaymentType] intValue];
    newTransaction.transactionType        = [transactionDetails[kTransactionType] intValue];
    NSArray *arrayWithAttachements        = transactionDetails[kTransactionAttachemts];
    newTransaction.transactionAttachments = arrayWithAttachements.encode;
    newTransaction.transactionLatitude    = [transactionDetails[kTransactionLatitude] doubleValue];
    newTransaction.transactionLongitude   = [transactionDetails[kTransactionLongitude] doubleValue];
    newTransaction.transactionWarrienty   = transactionDetails[kTransactionWarrienty];
  
    switch ([transactionDetails[kTransactionType] intValue]) {
        case kTransactionTypeIncome:
            
            wallet.walletBalance = [wallet.walletBalance decimalNumberByAdding:[[NSDecimalNumber alloc] initWithString:transactionDetails[kTransactionAmount]]];
            break;
        case kTransactionTypeExpense:
            wallet.walletBalance = [wallet.walletBalance decimalNumberBySubtracting:[[NSDecimalNumber alloc] initWithString:transactionDetails[kTransactionAmount]]];
            break;
            
        default:
            break;
    }
    
    [wallet addTransactionsObject:newTransaction];
    
    if(![context save:&error]) {
        NSLog(@"Error: %@",[error localizedDescription]);
    } else {
        NSLog(@"successfull saved");
    }
}

+ (void)createWarrientyTransaction:(NSDictionary *)warrientyInfo toWallet:(Wallet *)wallet {
    
    NSDictionary* userCurrentLocation = [iMoneyUtils getUserCurrentLocation];
    NSError *error = nil;
    NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
    
    Transaction *newTransaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction"
                                                                inManagedObjectContext:context];
    
    newTransaction.transactionAmount      = [[NSDecimalNumber alloc] initWithString:warrientyInfo[@"WarrientyAmount"]];
    newTransaction.transactionCategory    = kTransactionCategorySale;
    newTransaction.transactionDate        = [iMoneyUtils getTodayFormatedDate];
    newTransaction.transactionDescription = @"Warrienty";
    newTransaction.transactionPayee       = @"";
    newTransaction.transactionPaymentType = kPaymentTypeCash;
    
    if ([[warrientyInfo objectForKey:@"WarrientyType"] isEqualToString:@"Income"]) {
        newTransaction.transactionType    = kTransactionTypeIncome;
        wallet.walletBalance = [wallet.walletBalance decimalNumberByAdding:newTransaction.transactionAmount];
    } else {
        newTransaction.transactionType    = kTransactionTypeExpense;
        wallet.walletBalance = [wallet.walletBalance decimalNumberBySubtracting:newTransaction.transactionAmount];
    }
    newTransaction.transactionAttachments = @[].encode;
    newTransaction.transactionLatitude    = [userCurrentLocation[kTransactionLatitude] doubleValue];
    newTransaction.transactionLongitude   = [userCurrentLocation[kTransactionLongitude] doubleValue];
    newTransaction.transactionWarrienty   = [iMoneyUtils getWarrientyLength:warrientyInfo[@"WarrientyLength"]];
    
    [wallet addTransactionsObject:newTransaction];
    
    if(![context save:&error]) {
        NSLog(@"Error: %@",[error localizedDescription]);
    } else {
        NSLog(@"successfull saved");
    }
}

+ (void)adjustWalletBalance:(Wallet *)wallet withBalance:(NSString *)newAmount {
    
    NSDictionary* userCurrentLocation = [iMoneyUtils getUserCurrentLocation];
    NSError *error = nil;
    NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
    
    Transaction *newTransaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction"
                                                                inManagedObjectContext:context];
    
    newTransaction.transactionCategory    = kTransactionCategoryOther;
    newTransaction.transactionDate        = [iMoneyUtils getTodayFormatedDate];
    newTransaction.transactionDescription = @"";
    newTransaction.transactionPayee       = @"";
    newTransaction.transactionPaymentType = kPaymentTypeCash;
    newTransaction.transactionAttachments = @[].encode;
    newTransaction.transactionLatitude    = [userCurrentLocation[kTransactionLatitude] doubleValue];
    newTransaction.transactionLongitude   = [userCurrentLocation[kTransactionLongitude] doubleValue];
    
    NSDecimalNumber *incomeNumber = [[NSDecimalNumber alloc] initWithString:newAmount];
    
    if (wallet.walletBalance.doubleValue >= incomeNumber.doubleValue)
    {
        newTransaction.transactionType = kTransactionTypeExpense;
        double transactionAmount = wallet.walletBalance.doubleValue - incomeNumber.doubleValue;
        newTransaction.transactionAmount = [[NSDecimalNumber alloc] initWithDouble:transactionAmount];
    }
    else
    {
        newTransaction.transactionType = kTransactionTypeIncome;
        double transactionAmount = incomeNumber.doubleValue - wallet.walletBalance.doubleValue;
        newTransaction.transactionAmount = [[NSDecimalNumber alloc] initWithDouble:transactionAmount];
    }
    
    [wallet addTransactionsObject:newTransaction];
    
    wallet.walletBalance = incomeNumber;
    
    if(![context save:&error]) {
        NSLog(@"Error: %@",[error localizedDescription]);
    } else {
        NSLog(@"Successfull updated wallet amount");
    }
}

@end
