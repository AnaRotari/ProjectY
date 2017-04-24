//
//  CoreDataDebtManager.m
//  iMoney
//
//  Created by Alex on 4/24/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "CoreDataDebtManager.h"

@implementation CoreDataDebtManager

+ (NSMutableArray <Debt *> *)getAllDebts:(DebtsSort)sortOption {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Debt"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSSortDescriptor *exerciseOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"debtSort" ascending:YES];
    
    if (sortOption == DebtsSortByCreationDateNewest)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"debtCreationDate" ascending:YES];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    if (sortOption == DebtsSortByCreationDateOldest)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"debtCreationDate" ascending:NO];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    if (sortOption == DebtsSortByNameAZ)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"debtName" ascending:YES];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    if (sortOption == DebtsSortByNameZA)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"debtName" ascending:NO];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    if (sortOption == DebtsSortByAmountAscending)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"debtTotalAmount" ascending:YES];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    if (sortOption == DebtsSortByAmountDescending)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"debtTotalAmount" ascending:NO];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray.mutableCopy;
}

+ (void)createDebtWithOptions:(NSDictionary *)options {
    
    Debt *lastItem = [[CoreDataDebtManager getAllDebts:DebtsSortByAmountAscending] lastObject];
    
    NSError *error = nil;
    NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
    
    Debt *newDebt = [NSEntityDescription insertNewObjectForEntityForName:@"Debt"
                                                  inManagedObjectContext:context];
    
    newDebt.debtName          = [options objectForKey:@"debtName"];
    newDebt.debtType          = [[options objectForKey:@"debtType"] intValue];
    newDebt.debtDescription   = [options objectForKey:@"debtDescription"];
    newDebt.debtTotalAmount   = [[NSDecimalNumber alloc] initWithString:[options objectForKey:@"debtTotalAmount"]];
    newDebt.debtCurrentAmount = [[NSDecimalNumber alloc] initWithString:@"0"];
    newDebt.debtStartDate     = [options objectForKey:@"debtStartDate"];
    newDebt.debtFinishDate    = [options objectForKey:@"debtFinishDate"];
    newDebt.wallet            = [options objectForKey:@"wallet"];
    newDebt.debtSort          = lastItem.debtSort + 1;
    newDebt.debtCreationDate  = [iMoneyUtils getTodayFormatedDate];
    
    if(![context save:&error]) {
        NSLog(@"Error: %@",[error localizedDescription]);
    } else {
        NSLog(@"successfull saved debt");
    }
    [self generateTransactionForNewDebt:newDebt];
}

+ (void)generateTransactionForNewDebt:(Debt *)debt {
    
    NSDictionary* userCurrentLocation = [iMoneyUtils getUserCurrentLocation];
    
    NSDictionary *options = @{ kTransactionAmount      : debt.debtTotalAmount.stringValue,
                               kTransactionAttachemts  : @[],
                               kTransactionCategory    : @(kTransactionCategoryDebts),
                               kTransactionDescription : debt.debtName,
                               kTransactionPayee       : @"  ",
                               kTransactionPaymentType : @(kPaymentTypeCash),
                               kTransactionType        : @(debt.debtType),
                               kTransactionDate        : [iMoneyUtils getTodayFormatedDate],
                               kTransactionLatitude    : @([userCurrentLocation[kTransactionLatitude] doubleValue]),
                               kTransactionLongitude   : @([userCurrentLocation[kTransactionLongitude] doubleValue])};
    
    [self createTransaction:options toWallet:debt.wallet andDebt:debt];
}

+ (void)createTransaction:(NSDictionary *)transactionDetails toWallet:(Wallet *)wallet andDebt:(Debt *) debt {
    
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
    [debt addTransactionsObject:newTransaction];
    
    if(![context save:&error]) {
        NSLog(@"Error: %@",[error localizedDescription]);
    } else {
        NSLog(@"successfull saved");
    }
}

+ (void)createNewRecordForDebt:(Debt *)debt withAmount:(NSString *)amount {
    
    NSDictionary* userCurrentLocation = [iMoneyUtils getUserCurrentLocation];
    
    NSDictionary *options = @{ kTransactionAmount      : amount,
                               kTransactionAttachemts  : @[],
                               kTransactionCategory    : @(kTransactionCategoryDebts),
                               kTransactionDescription : debt.debtName,
                               kTransactionPayee       : @"  ",
                               kTransactionPaymentType : @(kPaymentTypeCash),
                               kTransactionType        : @(!debt.debtType),
                               kTransactionDate        : [iMoneyUtils getTodayFormatedDate],
                               kTransactionLatitude    : @([userCurrentLocation[kTransactionLatitude] doubleValue]),
                               kTransactionLongitude   : @([userCurrentLocation[kTransactionLongitude] doubleValue])};
    
    [self createTransaction:options toWallet:debt.wallet andDebt:debt];   
}

@end
