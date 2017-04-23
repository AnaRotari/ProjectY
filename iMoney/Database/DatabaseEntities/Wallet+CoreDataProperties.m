//
//  Wallet+CoreDataProperties.m
//  
//
//  Created by Alex on 4/23/17.
//
//

#import "Wallet+CoreDataProperties.h"

@implementation Wallet (CoreDataProperties)

+ (NSFetchRequest<Wallet *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Wallet"];
}

@dynamic walletBalance;
@dynamic walletColor;
@dynamic walletCurrency;
@dynamic walletDescription;
@dynamic walletID;
@dynamic walletName;
@dynamic walletSort;
@dynamic plannedPayment;
@dynamic transactions;
@dynamic budget;

@end
