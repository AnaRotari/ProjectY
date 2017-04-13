//
//  ListItem+CoreDataProperties.h
//  
//
//  Created by Ivan on 4/13/17.
//
//

#import "ListItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ListItem (CoreDataProperties)

+ (NSFetchRequest<ListItem *> *)fetchRequest;

@property (nonatomic) BOOL itemIsDone;
@property (nullable, nonatomic, copy) NSString *itemName;
@property (nonatomic) int16_t itemSort;
@property (nullable, nonatomic, retain) ShoppingList *list;

@end

NS_ASSUME_NONNULL_END
