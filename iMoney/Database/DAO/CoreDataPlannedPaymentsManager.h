//
//  CoreDataPlannedPaymentsManager.h
//  iMoney
//
//  Created by Alex on 4/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataPlannedPaymentsManager : NSObject

+ (NSMutableArray <PlannedPayments *> *)getAllPlannedPayments:(PlannedPaymentsSort)sortOption;
+ (void)savePlannedPayment:(PlannedPayments *)plannedPayment withData:(NSDictionary *)contentDict;

@end
