//
//  Wallet+CoreDataClass.h
//  
//
//  Created by Alexandr Pavlov on 3/28/17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Transaction;

NS_ASSUME_NONNULL_BEGIN

@interface Wallet : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Wallet+CoreDataProperties.h"
