//
//  CoreDataShoppingListManager.m
//  iMoney
//
//  Created by Alex on 4/11/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "CoreDataShoppingListManager.h"

@implementation CoreDataShoppingListManager

+ (void)createShoppingListWithName:(NSString *)listName {
    
    ShoppingList *shoppingList = [NSEntityDescription insertNewObjectForEntityForName:@"ShoppingList"
                                                               inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    if ([listName isEqualToString:@""]) {
        listName = @"Shopping list";
    }
    shoppingList.listName = listName;
    [[CoreDataAccessLayer sharedInstance] saveContext];
}

+ (void)createItemInShoppingList:(ShoppingList *)shoppingList withName:(NSString *)itemName {
    
    ListItem *lastItem = [[CoreDataShoppingListManager getAllItems] lastObject];
    
    ListItem *listItem = [NSEntityDescription insertNewObjectForEntityForName:@"ListItem"
                                                       inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    listItem.itemIsDone = NO;
    listItem.itemName = itemName;
    listItem.itemSort = lastItem.itemSort + 1;
    [shoppingList addItemsObject:listItem];
    
    [[CoreDataAccessLayer sharedInstance] saveContext];
}

+ (NSArray <ShoppingList *> *)getAllShoppingLists {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"ShoppingList"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    [request setReturnsObjectsAsFaults:NO];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

+ (NSArray <ListItem *> *)getAllItemsForShoppingList:(ShoppingList *)list {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"ListItem"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSSortDescriptor *exerciseOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"itemSort" ascending:YES];
    [request setSortDescriptors:@[exerciseOrderDescriptor]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"list == %@",list];
    [request setPredicate:predicate];
    
    [request setReturnsObjectsAsFaults:NO];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

+ (NSArray <ListItem *> *)getAllItems {
    
    NSError *requestError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"ListItem"
                                                   inManagedObjectContext:[[CoreDataAccessLayer sharedInstance] managedObjectContext]];
    [request setEntity:description];
    
    NSSortDescriptor *exerciseOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"itemSort" ascending:YES];
    [request setSortDescriptors:@[exerciseOrderDescriptor]];
    
    [request setReturnsObjectsAsFaults:NO];
    
    NSArray *resultArray = [[[CoreDataAccessLayer sharedInstance] managedObjectContext ] executeFetchRequest:request
                                                                                                       error:&requestError];
    return resultArray;
}

@end
