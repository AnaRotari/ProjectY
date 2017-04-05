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
+ (NSArray <Transaction *> *)getAllTransactionForWallet:(Wallet *)wallet;
+ (NSArray <Transaction *> *)getTodayTransactionsForWallet:(Wallet *)wallet;

@end
