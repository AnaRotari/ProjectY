//
//  PlannedPaymentsNotificationManager.h
//  iMoney
//
//  Created by Alex on 4/22/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlannedPaymentsNotificationManager : NSObject

+ (void)createTestInteractiveNotification;

+ (void)handleLocalNotification:(UILocalNotification *)notification;

@end
