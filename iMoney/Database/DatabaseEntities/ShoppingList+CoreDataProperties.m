//
//  ShoppingList+CoreDataProperties.m
//  
//
//  Created by Alex on 4/23/17.
//
//

#import "ShoppingList+CoreDataProperties.h"

@implementation ShoppingList (CoreDataProperties)

+ (NSFetchRequest<ShoppingList *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ShoppingList"];
}

@dynamic listName;
@dynamic items;

@end
