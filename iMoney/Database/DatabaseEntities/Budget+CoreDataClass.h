//
//  Budget+CoreDataClass.h
//  
//
//  Created by Alex on 4/23/17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Transaction, Wallet;

NS_ASSUME_NONNULL_BEGIN

@interface Budget : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Budget+CoreDataProperties.h"
