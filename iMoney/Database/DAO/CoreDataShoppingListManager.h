//
//  CoreDataShoppingListManager.h
//  iMoney
//
//  Created by Alex on 4/11/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataShoppingListManager : NSObject

+ (void)createShoppingListWithName:(NSString *)listName;
+ (void)createItemInShoppingList:(ShoppingList *)shoppingList withName:(NSString *)itemName;

+ (NSArray <ShoppingList *> *)getAllShoppingLists;
+ (NSArray <ListItem *> *)getAllItemsForShoppingList:(ShoppingList *)list;

@end
