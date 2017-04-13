//
//  Transaction+CoreDataProperties.m
//  
//
//  Created by Ivan on 4/13/17.
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
@dynamic transactionPayee;
@dynamic transactionPaymentType;
@dynamic transactionType;
@dynamic transactionLatitude;
@dynamic transactionLongitude;
@dynamic wallet;

@end
