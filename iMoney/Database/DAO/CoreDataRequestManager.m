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

@end
