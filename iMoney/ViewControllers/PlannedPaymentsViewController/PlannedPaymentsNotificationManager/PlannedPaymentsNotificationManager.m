//
//  PlannedPaymentsNotificationManager.m
//  iMoney
//
//  Created by Alex on 4/22/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "PlannedPaymentsNotificationManager.h"

@implementation PlannedPaymentsNotificationManager

+ (void)createTestInteractiveNotification {
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // 1. Create the actions **************************************************
    UIMutableUserNotificationAction *incrementAction = [[UIMutableUserNotificationAction alloc] init];
    incrementAction.identifier = @"INCREMENT_ACTION";
    incrementAction.title = @"Add +1";
    incrementAction.activationMode = UIUserNotificationActivationModeBackground;
    incrementAction.authenticationRequired = NO;
    incrementAction.destructive = NO;
    
    UIMutableUserNotificationAction *decrementAction = [[UIMutableUserNotificationAction alloc] init];
    decrementAction.identifier = @"DECREMENT_ACTION";
    decrementAction.title = @"Sub -1";
    decrementAction.activationMode = UIUserNotificationActivationModeBackground;
    decrementAction.authenticationRequired = NO;
    decrementAction.destructive = NO;
    
    UIMutableUserNotificationAction *resetAction = [[UIMutableUserNotificationAction alloc] init];
    resetAction.identifier = @"RESET_ACTION";
    resetAction.title = @"Reset";
    resetAction.activationMode = UIUserNotificationActivationModeBackground;
    resetAction.authenticationRequired = NO;
    resetAction.destructive = YES;

    // 2. Create the category ***********************************************
    UIMutableUserNotificationCategory *counterCategory = [[UIMutableUserNotificationCategory alloc] init];
    counterCategory.identifier = @"COUNTER_CATEGORY";
    [counterCategory setActions:@[incrementAction,decrementAction,resetAction]
                     forContext:UIUserNotificationActionContextDefault];
    
//    [counterCategory setActions:@[incrementAction,decrementAction]
//                     forContext:UIUserNotificationActionContextMinimal];

    // 3. Notification Registration *****************************************

    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert
                                                                             categories:[NSSet setWithObject:counterCategory]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"YO MADAFAKA";
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.fireDate = [NSDate date];
    notification.category = @"COUNTER_CATEGORY";
    notification.repeatInterval = NSCalendarUnitMinute;
    notification.userInfo = @{@"test":@"MEGA TEST"};
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}

+ (void)handleLocalNotification:(UILocalNotification *)notification {
    
    // Handle notification action *****************************************
//    if notification.category == "COUNTER_CATEGORY" {
//        
//        let action:Actions = Actions.fromRaw(identifier!)!
//        let counter = Counter();
//        
//        switch action{
//            
//        case "INCREMENT_ACTION":
//            counter++
//            
//        case "DECREMENT_ACTION":
//            counter--
//            
//        case "RESET_ACTION":
//            counter.currentTotal = 0
//            
//        }
//    }
}

@end
