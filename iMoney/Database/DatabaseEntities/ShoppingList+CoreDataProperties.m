//
//  ShoppingList+CoreDataProperties.m
//  
//
//  Created by Alexandr Pavlov on 4/11/17.
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
