//
//  PlannedPaymentsNotificationManager.h
//  iMoney
//
//  Created by Alex on 4/22/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const PlannedPaymentsNotificationCategoryIdentifier;
extern NSString* const PlannedPaymentsNotificationConfirmButtonIdentifier;
extern NSString* const PlannedPaymentsNotificationIgnoreButtonIdentifier;

@interface PlannedPaymentsNotificationManager : NSObject

+ (void)createScheduledNotificationForPlannedPayment:(PlannedPayments *)payment;
+ (void)deleteScheduledNotificationForPlannedPayment:(PlannedPayments *)payment;
+ (void)handleLocalNotification:(UILocalNotification *)notification withIdentifier:(NSString *)identifier;

@end
