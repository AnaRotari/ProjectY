//
//  Wallet+CoreDataClass.h
//  
//
//  Created by Alex on 4/18/17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PlannedPayments, Transaction;

NS_ASSUME_NONNULL_BEGIN

@interface Wallet : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Wallet+CoreDataProperties.h"
