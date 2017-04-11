//
//  Transaction+CoreDataProperties.m
//  
//
//  Created by Alexandr Pavlov on 4/11/17.
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
@dynamic transactionLocation;
@dynamic transactionPayee;
@dynamic transactionPaymentType;
@dynamic transactionType;
@dynamic wallet;

@end
