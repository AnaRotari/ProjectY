//
//  Budget+CoreDataProperties.m
//  
//
//  Created by Alex on 4/23/17.
//
//

#import "Budget+CoreDataProperties.h"

@implementation Budget (CoreDataProperties)

+ (NSFetchRequest<Budget *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Budget"];
}

@dynamic budgetTotalAmount;
@dynamic budgetFinishDate;
@dynamic budgetInterval;
@dynamic budgetName;
@dynamic budgetStartDate;
@dynamic budgetCurrentAmount;
@dynamic transactions;
@dynamic wallets;

@end
