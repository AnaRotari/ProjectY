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

@dynamic walletColor;
@dynamic walletCurrency;
@dynamic walletDescription;
@dynamic walletID;
@dynamic walletBalance;
@dynamic walletName;
@dynamic walletSort;

@end
