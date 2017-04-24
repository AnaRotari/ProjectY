//
//  PlannedPayments+CoreDataProperties.m
//  
//
//  Created by Alex on 4/24/17.
//
//

#import "PlannedPayments+CoreDataProperties.h"

@implementation PlannedPayments (CoreDataProperties)

+ (NSFetchRequest<PlannedPayments *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"PlannedPayments"];
}

@dynamic plannedAmount;
@dynamic plannedCategory;
@dynamic plannedDate;
@dynamic plannedDescription;
@dynamic plannedFrequency;
@dynamic plannedName;
@dynamic plannedSort;
@dynamic plannedType;
@dynamic wallet;

@end
