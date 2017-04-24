//
//  Transaction+CoreDataClass.h
//  
//
//  Created by Alex on 4/24/17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Budget, Debt, Wallet;

NS_ASSUME_NONNULL_BEGIN

@interface Transaction : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Transaction+CoreDataProperties.h"
