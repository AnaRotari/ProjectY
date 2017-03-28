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
    
    
}

@end
