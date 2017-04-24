//
//  Transaction+CoreDataProperties.m
//  
//
//  Created by Alex on 4/24/17.
//
//

#import "Transaction+CoreDataProperties.h"

@implementation Transaction (CoreDataProperties)

+ (NSFetchRequest<Transaction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
}

@dynamic transactionAmount;
@dynamic transactionAttachments;
@dynamic transactionCategory;
@dynamic transactionDate;
@dynamic transactionDescription;
@dynamic transactionLatitude;
@dynamic transactionLongitude;
@dynamic transactionPayee;
@dynamic transactionPaymentType;
@dynamic transactionType;
@dynamic transactionWarrienty;
@dynamic budget;
@dynamic wallet;

@end
