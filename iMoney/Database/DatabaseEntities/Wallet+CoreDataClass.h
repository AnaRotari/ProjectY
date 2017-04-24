//
//  Wallet+CoreDataClass.h
//  
//
//  Created by Alex on 4/24/17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Budget, Debt, PlannedPayments, Transaction;

NS_ASSUME_NONNULL_BEGIN

@interface Wallet : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Wallet+CoreDataProperties.h"
