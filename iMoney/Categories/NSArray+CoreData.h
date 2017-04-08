//
//  NSArray+CoreData.h
//  iMoney
//
//  Created by Alex on 4/8/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CoreData)

- (NSData *)encode;
- (NSArray *)arrayWithData:(NSData *)data;

@end
