//
//  ShoppingList+CoreDataProperties.h
//  
//
//  Created by Alex on 4/24/17.
//
//

#import "ShoppingList+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ShoppingList (CoreDataProperties)

+ (NSFetchRequest<ShoppingList *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *listName;
@property (nullable, nonatomic, retain) NSSet<ListItem *> *items;

@end

@interface ShoppingList (CoreDataGeneratedAccessors)

- (void)addItemsObject:(ListItem *)value;
- (void)removeItemsObject:(ListItem *)value;
- (void)addItems:(NSSet<ListItem *> *)values;
- (void)removeItems:(NSSet<ListItem *> *)values;

@end

NS_ASSUME_NONNULL_END
