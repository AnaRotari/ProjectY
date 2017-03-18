//
//  CoreDataRequestManager.m
//  Six Pack Abs
//
//  Created by Alex Overseer on 10/26/16.
//  Copyright © 2016 Softintercom. All rights reserved.
//

#import "CoreDataRequestManager.h"
#import "CoreDataAccessLayer.h"

@implementation CoreDataRequestManager

+ (void)test1 {
    
    Test *test = [NSEntityDescription insertNewObjectForEntityForName:@"Test"
                                                inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    test.testAttribute = [NSString stringWithFormat:@"Lol: %d",arc4random_uniform(1999)];;
    NSError *error = nil;
    if(![[[CoreDataAccessLayer sharedInstance] managedObjectContext] save:&error])
    {
        NSLog(@"%@",[error localizedDescription]);
    }
}

@end
