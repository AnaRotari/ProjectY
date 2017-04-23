//
//  CoreDataBudgetManager.m
//  iMoney
//
//  Created by Alex on 4/23/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "CoreDataBudgetManager.h"

@implementation CoreDataBudgetManager

+ (void)createBudgetWithOptions:(NSDictionary *)options {
    
    NSError *error = nil;
    NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
    
    Budget *newBudget = [NSEntityDescription insertNewObjectForEntityForName:@"Budget"
                                                      inManagedObjectContext:context];
    
    newBudget.budgetName = [options objectForKey:@"budgetName"];
    newBudget.budgetTotalAmount = [[NSDecimalNumber alloc] initWithString:[options objectForKey:@"budgetTotalAmount"]];
    newBudget.budgetStartDate = [options objectForKey:@"budgetStartDate"];
    newBudget.budgetFinishDate = [options objectForKey:@"budgetFinishDate"];
    newBudget.budgetInterval = [[options valueForKey:@"budgetInterval"] intValue];
    newBudget.budgetCurrentAmount = [[NSDecimalNumber alloc] initWithInt:0];
    [newBudget addWallets:[options objectForKey:@"wallets"]];
    
    if(![context save:&error]) {
        NSLog(@"Error: %@",[error localizedDescription]);
    } else {
        NSLog(@"successfull saved budget");
    }
}

+ (NSArray <Budget *> *)getAllBudgetsForInterval:(BudgetInterval)interval {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Budget"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSSortDescriptor *exerciseOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"budgetStartDate" ascending:YES];
    [request setSortDescriptors:@[exerciseOrderDescriptor]];
    
    if (interval != BudgetIntervalAll) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"budgetInterval == %d",interval];
        [request setPredicate:predicate];
    }
    
    [request setReturnsObjectsAsFaults:NO];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

@end
