//
//  CoreDataPlannedPaymentsManager.m
//  iMoney
//
//  Created by Alex on 4/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "CoreDataPlannedPaymentsManager.h"

@implementation CoreDataPlannedPaymentsManager

+ (NSMutableArray <PlannedPayments *> *)getAllPlannedPayments:(PlannedPaymentsSort)sortOption {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"PlannedPayments"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    if (sortOption == PlannedPaymentsSortByCreationDateNewest)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedDate" ascending:YES];
        [request setSortDescriptors:@[sortOrderDescriptor]];
    }
    if (sortOption == PlannedPaymentsSortByCreationDateOldest)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedDate" ascending:NO];
        [request setSortDescriptors:@[sortOrderDescriptor]];
    }
    if (sortOption == PlannedPaymentsSortByNameAZ)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedName" ascending:YES];
        [request setSortDescriptors:@[sortOrderDescriptor]];
    }
    if (sortOption == PlannedPaymentsSortByNameZA)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedName" ascending:NO];
        [request setSortDescriptors:@[sortOrderDescriptor]];
    }
    if (sortOption == PlannedPaymentsSortByAmountAscending)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedAmount" ascending:YES];
        [request setSortDescriptors:@[sortOrderDescriptor]];
    }
    if (sortOption == PlannedPaymentsSortByAmountDescending)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedAmount" ascending:NO];
        [request setSortDescriptors:@[sortOrderDescriptor]];
    }
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray.mutableCopy;
}

@end
