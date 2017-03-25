//
//  Wallet+CoreDataProperties.m
//  
//
//  Created by Alex on 3/26/17.
//
//

#import "Wallet+CoreDataProperties.h"

@implementation Wallet (CoreDataProperties)

+ (NSFetchRequest<Wallet *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Wallet"];
}

@dynamic walletCurrency;
@dynamic walletDescription;
@dynamic walletID;
@dynamic walletInitialBalance;
@dynamic walletName;
@dynamic walletColor;

@end
