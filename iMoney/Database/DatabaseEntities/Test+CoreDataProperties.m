//
//  Test+CoreDataProperties.m
//  
//
//  Created by Alex on 3/18/17.
//
//

#import "Test+CoreDataProperties.h"

@implementation Test (CoreDataProperties)

+ (NSFetchRequest<Test *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Test"];
}

@dynamic testAttribute;

@end
