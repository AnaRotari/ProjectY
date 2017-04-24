//
//  CoreDataDebtManager.h
//  iMoney
//
//  Created by Alex on 4/24/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataDebtManager : NSObject

+ (void)createDebtWithOptions:(NSDictionary *)options;
+ (NSMutableArray <Debt *> *)getAllDebts:(DebtsSort)sortOption;

+ (void)createNewRecordForDebt:(Debt *)debt withAmount:(NSString *)amount;

@end
