//
//  CoreDataRequestManager.m
//  Six Pack Abs
//
//  Created by Alex Overseer on 10/26/16.
//  Copyright © 2016 Softintercom. All rights reserved.
//

#import "CoreDataRequestManager.h"

@implementation CoreDataRequestManager

+ (NSArray *)getAllWallets {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Wallet"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSSortDescriptor *exerciseOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"walletSort"
                                                                            ascending:YES];
    [request setSortDescriptors:@[exerciseOrderDescriptor]];
    
    [request setReturnsObjectsAsFaults:NO];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

@end
