//
//  CoreDataInsertManager.h
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataAccessLayer.h"

@interface CoreDataInsertManager : NSObject

+ (void)createWallet:(NSDictionary *)walletValues;
+ (void)createTransaction:(NSDictionary *)transactionDetails toWallet:(Wallet *)wallet;

@end
