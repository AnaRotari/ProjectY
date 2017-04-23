//
//  Budget+CoreDataProperties.m
//  
//
//  Created by Alex on 4/24/17.
//
//

#import "Budget+CoreDataProperties.h"

@implementation Budget (CoreDataProperties)

+ (NSFetchRequest<Budget *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Budget"];
}

@dynamic budgetCurrentAmount;
@dynamic budgetFinishDate;
@dynamic budgetInterval;
@dynamic budgetName;
@dynamic budgetStartDate;
@dynamic budgetTotalAmount;
@dynamic transactions;
@dynamic wallets;

@end
