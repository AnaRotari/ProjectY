//
//  CoreDataRequestManager.m
//  Six Pack Abs
//
//  Created by Alex Overseer on 10/26/16.
//  Copyright © 2016 Softintercom. All rights reserved.
//

#import "CoreDataRequestManager.h"

@implementation CoreDataRequestManager

+ (NSArray <Wallet *> *)getAllWallets {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Wallet"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSSortDescriptor *exerciseOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"walletSort" ascending:YES];
    [request setSortDescriptors:@[exerciseOrderDescriptor]];
    
    [request setReturnsObjectsAsFaults:NO];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

+ (NSArray <Wallet *> *)getAllWalletsWithoutWallet:(Wallet*)extractedWallet {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Wallet"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSSortDescriptor *exerciseOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"walletSort" ascending:YES];
    [request setSortDescriptors:@[exerciseOrderDescriptor]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"walletID != %@",extractedWallet.walletID];
    [request setPredicate:predicate];
    
    [request setReturnsObjectsAsFaults:NO];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

+ (NSArray <Transaction *> *)getAllTransactions {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Transaction"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

+ (NSArray <Transaction *> *)getTodayTransactionsForWallet:(Wallet *)wallet {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Transaction"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wallet == %@ AND transactionDate == %@",wallet,[iMoneyUtils getTodayFormatedDate]];
    [request setPredicate:predicate];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

+ (NSArray <Transaction *> *)getAllTransactionForWallet:(Wallet *)wallet {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Transaction"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wallet == %@",wallet];
    [request setPredicate:predicate];
    
    NSSortDescriptor *transactionDescriptor = [[NSSortDescriptor alloc] initWithKey:@"transactionDate" ascending:NO];
    [request setSortDescriptors:@[transactionDescriptor]];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    
    return resultArray;
}

+ (NSArray <Transaction *> *)getAllTransactionForWallet:(Wallet *)wallet withSortOption:(SortOptions)option {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Transaction"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSSortDescriptor *transactionDescriptor = [[NSSortDescriptor alloc] initWithKey:@"transactionDate" ascending:NO];
    [request setSortDescriptors:@[transactionDescriptor]];
    
    NSDate *referenceDay = [[NSDate alloc] init];
    
    switch (option) {
        case kSortOptionShowAll:
            referenceDay = [NSDate dateWithTimeIntervalSince1970:NSTimeIntervalSince1970];
            break;
        case kSortOptionShowToday:
            referenceDay = [iMoneyUtils getTodayFormatedDate];
            break;
        case kSortOptionShowLastWeek:
            referenceDay = [[iMoneyUtils getTodayFormatedDate] dateByAddingTimeInterval: -7 * 24 * 60 * 60];
            break;
        case kSortOptionShowLastMonth:
            referenceDay = [[iMoneyUtils getTodayFormatedDate] dateByAddingTimeInterval: -31 * 24 * 60 * 60];
            break;
        case kSortOptionShowLastYear:
            referenceDay = [[iMoneyUtils getTodayFormatedDate] dateByAddingTimeInterval: -365 * 24 * 60 * 60];
            break;
        default:
            break;
    }
    
    NSDate *todayDate = [iMoneyUtils getTodayFormatedDate];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wallet == %@ AND (transactionDate >= %@) AND (transactionDate <= %@)",wallet,referenceDay,todayDate];
    [request setPredicate:predicate];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

+ (NSArray <Transaction *> *)getAllTransactionsForSortOption:(SortOptions)option {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Transaction"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSSortDescriptor *transactionDescriptor = [[NSSortDescriptor alloc] initWithKey:@"transactionDate" ascending:NO];
    [request setSortDescriptors:@[transactionDescriptor]];
    
    NSDate *referenceDay = [[NSDate alloc] init];
    
    switch (option) {
        case kSortOptionShowAll:
            referenceDay = [NSDate dateWithTimeIntervalSince1970:NSTimeIntervalSince1970];
            break;
        case kSortOptionShowToday:
            referenceDay = [iMoneyUtils getTodayFormatedDate];
            break;
        case kSortOptionShowLastWeek:
            referenceDay = [[iMoneyUtils getTodayFormatedDate] dateByAddingTimeInterval: -7 * 24 * 60 * 60];
            break;
        case kSortOptionShowLastMonth:
            referenceDay = [[iMoneyUtils getTodayFormatedDate] dateByAddingTimeInterval: -31 * 24 * 60 * 60];
            break;
        case kSortOptionShowLastYear:
            referenceDay = [[iMoneyUtils getTodayFormatedDate] dateByAddingTimeInterval: -365 * 24 * 60 * 60];
            break;
        default:
            break;
    }
    
    NSDate *todayDate = [iMoneyUtils getTodayFormatedDate];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(transactionDate >= %@) AND (transactionDate <= %@)",referenceDay,todayDate];
    [request setPredicate:predicate];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

@end
