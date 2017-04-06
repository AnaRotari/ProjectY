//
//  AppDelegate+Notifications.m
//  iMoney
//
//  Created by Alex on 4/6/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "AppDelegate+Notifications.h"

@implementation AppDelegate (Notifications)

- (void)setLocalInactivityNotification {
    
    NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications] ;
    
    for (UILocalNotification *localNotification in arrayOfLocalNotifications) {
        
        if ([localNotification.alertBody isEqualToString:@"Hey! You didn't record your expenses for few days, come back and do it!"])
        {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        }
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kAfterNDaysSwitchState] == YES)
    {
        NSCalendar *calendar = [NSCalendar currentCalendar] ;
        [calendar setLocale:[NSLocale currentLocale]];
        
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute)
                                                   fromDate:[NSDate date]];
        NSInteger day = [components day];
        
        NSDateComponents *component = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute)
                                                  fromDate:[[NSUserDefaults standardUserDefaults] objectForKey:kInactivityReminder]];
        
        NSInteger hour = [component hour];
        NSInteger minutes = [component minute];
        NSInteger newDay = day + [[NSUserDefaults standardUserDefaults] integerForKey:kInactivityLenght];
        [components setHour:hour];
        [components setMinute:minutes];
        [components setDay:newDay];
        
        NSDate *exactTime = [calendar dateFromComponents:components];
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = exactTime;
        localNotification.alertBody = [NSString stringWithFormat:@"%@", @"Hey! You didn't record your expenses for few days, come back and do it!"];
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

@end
