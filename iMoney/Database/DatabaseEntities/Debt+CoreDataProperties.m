//
//  Debt+CoreDataProperties.m
//  
//
//  Created by Alex on 4/24/17.
//
//

#import "Debt+CoreDataProperties.h"

@implementation Debt (CoreDataProperties)

+ (NSFetchRequest<Debt *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Debt"];
}

@dynamic debtType;
@dynamic debtName;
@dynamic debtDescription;
@dynamic debtTotalAmount;
@dynamic debtStartDate;
@dynamic debtFinishDate;
@dynamic debtSort;
@dynamic debtCreationDate;
@dynamic debtCurrentAmount;
@dynamic wallet;
@dynamic transactions;

@end
