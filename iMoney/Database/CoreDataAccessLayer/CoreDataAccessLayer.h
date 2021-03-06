//
//  CoreDataAccessLayer.h
//  Six Pack Abs
//
//  Created by Alex Overseer on 10/24/16.
//  Copyright © 2016 Softintercom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//Entities
#import "Wallet+CoreDataClass.h"
#import "Transaction+CoreDataClass.h"
#import "ShoppingList+CoreDataClass.h"
#import "ListItem+CoreDataClass.h"
#import "PlannedPayments+CoreDataClass.h"
#import "Budget+CoreDataClass.h"
#import "Debt+CoreDataClass.h"

@interface CoreDataAccessLayer : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataAccessLayer *)sharedInstance;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectContext *)managedObjectContext;
- (void)saveContext;
- (void)resetDatabase;

@end
