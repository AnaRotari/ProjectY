//
//  UIColor+CoreData.m
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "UIColor+CoreData.h"

@implementation UIColor (CoreData)

- (NSData *)encode {
    
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

- (UIColor *)colorWithData:(NSData *)data {
    
    return (UIColor *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
