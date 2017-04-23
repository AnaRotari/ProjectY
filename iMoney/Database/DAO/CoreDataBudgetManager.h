//
//  CoreDataBudgetManager.h
//  iMoney
//
//  Created by Alex on 4/23/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataBudgetManager : NSObject

+ (void)createBudgetWithOptions:(NSDictionary *)options;
+ (NSArray <Budget *> *)getAllBudgetsForInterval:(BudgetInterval)interval;

@end
