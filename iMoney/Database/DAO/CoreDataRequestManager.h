//
//  CoreDataRequestManager.h
//  Six Pack Abs
//
//  Created by Alex Overseer on 10/26/16.
//  Copyright © 2016 Softintercom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataAccessLayer.h"

@interface CoreDataRequestManager : NSObject

+ (NSArray <Wallet *> *)getAllWallets;
+ (NSArray <Wallet *> *)getAllWalletsWithoutWallet:(Wallet*)extractedWallet;

+ (NSArray <Transaction *> *)getAllTransactions;
+ (NSArray <Transaction *> *)getAllTransactionForWallet:(Wallet *)wallet;
+ (NSArray <Transaction *> *)getTodayTransactionsForWallet:(Wallet *)wallet;
+ (NSArray <Transaction *> *)getAllTransactionForWallet:(Wallet *)wallet withSortOption:(SortOptions)option;

+ (NSArray <Transaction *> *)getAllTransactionsForSortOption:(SortOptions)option;

@end
