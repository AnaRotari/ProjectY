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
    
    NSSortDescriptor *exerciseOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedSort" ascending:YES];
    
    if (sortOption == PlannedPaymentsSortByCreationDateNewest)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedDate" ascending:YES];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    if (sortOption == PlannedPaymentsSortByCreationDateOldest)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedDate" ascending:NO];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    if (sortOption == PlannedPaymentsSortByNameAZ)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedName" ascending:YES];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    if (sortOption == PlannedPaymentsSortByNameZA)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedName" ascending:NO];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    if (sortOption == PlannedPaymentsSortByAmountAscending)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedAmount" ascending:YES];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    if (sortOption == PlannedPaymentsSortByAmountDescending)
    {
        NSSortDescriptor *sortOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"plannedAmount" ascending:NO];
        [request setSortDescriptors:@[sortOrderDescriptor,exerciseOrderDescriptor]];
    }
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray.mutableCopy;
}

+ (void)savePlannedPayment:(PlannedPayments *)plannedPayment withData:(NSDictionary *)contentDict {
    
    PlannedPayments *lastPlannedPayment = [[CoreDataPlannedPaymentsManager getAllPlannedPayments:PlannedPaymentsSortByCreationDateNewest] lastObject];
    plannedPayment.plannedSort = lastPlannedPayment.plannedSort + 1;
    plannedPayment.plannedAmount = [[NSDecimalNumber alloc] initWithString:[contentDict objectForKey:@"plannedAmount"]];
    plannedPayment.plannedCategory = [[contentDict valueForKey:@"plannedCategory"] intValue];
    plannedPayment.plannedDate = [contentDict objectForKey:@"plannedDate"];
    plannedPayment.plannedDescription = [contentDict objectForKey:@"plannedDescription"];
    plannedPayment.plannedFrequency = [[contentDict valueForKey:@"plannedFrequency"] intValue];
    plannedPayment.plannedName = [contentDict objectForKey:@"plannedName"];
    plannedPayment.plannedType = [[contentDict valueForKey:@"plannedType"] intValue];
    
    Wallet *selectedWallet = [contentDict objectForKey:@"plannedWallet"];
    [selectedWallet addPlannedPaymentObject:plannedPayment];
    
    NSError *error = nil;
    NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
    
    if(![context save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    } else {
        NSLog(@"successfull saved planned payment");
    }
}

@end
