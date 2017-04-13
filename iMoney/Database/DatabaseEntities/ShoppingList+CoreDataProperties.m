//
//  ShoppingList+CoreDataProperties.m
//  
//
//  Created by Ivan on 4/13/17.
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
