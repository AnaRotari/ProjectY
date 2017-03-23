//
//  Wallet+CoreDataProperties.m
//  
//
//  Created by Alex on 3/23/17.
//
//

#import "Wallet+CoreDataProperties.h"

@implementation Wallet (CoreDataProperties)

+ (NSFetchRequest<Wallet *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Wallet"];
}

@dynamic walletID;
@dynamic walletInitialBalance;
@dynamic walletCurrency;
@dynamic walletName;
@dynamic walletDescription;

@end
