//
//  NSArray+CoreData.m
//  iMoney
//
//  Created by Alex on 4/8/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "NSArray+CoreData.h"

@implementation NSArray (CoreData)

- (NSData *)encode {
    
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

- (NSArray *)arrayWithData:(NSData *)data {
    
    return (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
