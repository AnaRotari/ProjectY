//
//  ListItem+CoreDataProperties.m
//  
//
//  Created by Alexandr Pavlov on 4/11/17.
//
//

#import "ListItem+CoreDataProperties.h"

@implementation ListItem (CoreDataProperties)

+ (NSFetchRequest<ListItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ListItem"];
}

@dynamic itemIsDone;
@dynamic itemName;
@dynamic itemSort;
@dynamic list;

@end
