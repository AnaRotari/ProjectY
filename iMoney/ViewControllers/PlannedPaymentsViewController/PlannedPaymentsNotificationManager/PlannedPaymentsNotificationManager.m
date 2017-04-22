//
//  PlannedPaymentsNotificationManager.m
//  iMoney
//
//  Created by Alex on 4/22/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "PlannedPaymentsNotificationManager.h"

NSString* const PlannedPaymentsNotificationCategoryIdentifier      = @"PlannedPaymentsNotificationCategoryIdentifier";
NSString* const PlannedPaymentsNotificationConfirmButtonIdentifier = @"PlannedPaymentsNotificationConfirmButtonIdentifier";
NSString* const PlannedPaymentsNotificationIgnoreButtonIdentifier  = @"PlannedPaymentsNotificationIgnoreButtonIdentifier";

@implementation PlannedPaymentsNotificationManager

+ (void)createScheduledNotificationForPlannedPayment:(PlannedPayments *)payment {
    
    UIMutableUserNotificationAction *confirmPaymentAction = [self getNotificationActionWithIdentifier:PlannedPaymentsNotificationConfirmButtonIdentifier
                                                                                             andTitle:@"Confirm"];
    UIMutableUserNotificationAction *ignorePaymentAction = [self getNotificationActionWithIdentifier:PlannedPaymentsNotificationIgnoreButtonIdentifier
                                                                                            andTitle:@"Ignore"];
    
    UIMutableUserNotificationCategory *plannedPaymentsCategory = [[UIMutableUserNotificationCategory alloc] init];
    plannedPaymentsCategory.identifier = PlannedPaymentsNotificationCategoryIdentifier;
    [plannedPaymentsCategory setActions:@[confirmPaymentAction,ignorePaymentAction]
                             forContext:UIUserNotificationActionContextDefault];
    [plannedPaymentsCategory setActions:@[confirmPaymentAction,ignorePaymentAction]
                             forContext:UIUserNotificationActionContextMinimal];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert
                                                                             categories:[NSSet setWithObject:plannedPaymentsCategory]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = payment.plannedName;
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.fireDate = payment.plannedDate;
    notification.category = PlannedPaymentsNotificationCategoryIdentifier;
    notification.userInfo = @{@"PlannedPayments" : [payment.objectID URIRepresentation].absoluteString};
    
    switch (payment.plannedFrequency) {
            
        case PlannedIntervalRepeatDaily:
            notification.repeatInterval = NSCalendarUnitDay;
            break;
        case PlannedIntervalRepeatWeekly:
            notification.repeatInterval = NSCalendarUnitWeekday;
            break;
        case PlannedIntervalRepeatMonthly:
            notification.repeatInterval = NSCalendarUnitMonth;
            break;
        case PlannedIntervalRepeatYearly:
            notification.repeatInterval = NSCalendarUnitYear;
            break;
        default:
            break;
    }
    //notification.repeatInterval = NSCalendarUnitMinute;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

+ (void)deleteScheduledNotificationForPlannedPayment:(PlannedPayments *)payment {
    
    NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications] ;
    
    for (UILocalNotification *localNotification in arrayOfLocalNotifications) {
        
        NSString *scheduledPlannedPaymentID = [localNotification.userInfo objectForKey:@"PlannedPayments"];
        NSString *plannedPaymendID = [payment.objectID URIRepresentation].absoluteString;
        
        if ([scheduledPlannedPaymentID isEqualToString:plannedPaymendID])
        {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
            break;
        }
    }
}

+ (void)handleLocalNotification:(UILocalNotification *)notification withIdentifier:(NSString *)identifier {
    
    if ([notification.category isEqualToString:PlannedPaymentsNotificationCategoryIdentifier]) {
        
        if ([identifier isEqualToString:PlannedPaymentsNotificationConfirmButtonIdentifier]) {
            
            NSArray <PlannedPayments *> *allPaymentsArray = [CoreDataPlannedPaymentsManager getAllPlannedPayments:PlannedPaymentsSortByCreationDateNewest];
            
            for (PlannedPayments *plannedPaymet in allPaymentsArray) {
                
                NSString *remotePlannedPaymentID = [notification.userInfo objectForKey:@"PlannedPayments"];
                NSString *localPlannedPaymendID  = [plannedPaymet.objectID URIRepresentation].absoluteString;
                
                if ([remotePlannedPaymentID isEqualToString:localPlannedPaymendID]) {
                    
                    NSDictionary* userCurrentLocation = [iMoneyUtils getUserCurrentLocation];
                    double latitude = [userCurrentLocation[kTransactionLatitude] doubleValue];
                    double longitude = [userCurrentLocation[kTransactionLongitude] doubleValue];
                    
                    NSDictionary *finalTransactionsDetails = @{kTransactionAmount      : plannedPaymet.plannedAmount.stringValue,
                                                               kTransactionAttachemts  : @[],
                                                               kTransactionCategory    : @(plannedPaymet.plannedCategory),
                                                               kTransactionDate        : [iMoneyUtils getTodayFormatedDate],
                                                               kTransactionDescription : plannedPaymet.plannedDescription,
                                                               kTransactionPayee       : @"",
                                                               kTransactionPaymentType : @(kPaymentTypeCash),
                                                               kTransactionType        : @(plannedPaymet.plannedType),
                                                               kTransactionLatitude    : @(latitude),
                                                               kTransactionLongitude   : @(longitude)};
                    
                    [CoreDataInsertManager createTransaction:finalTransactionsDetails
                                                    toWallet:plannedPaymet.wallet];
                    break;
                }
            }
        }
    }
}

+ (UIMutableUserNotificationAction *)getNotificationActionWithIdentifier:(NSString *)identifier andTitle:(NSString *)title {
    
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    action.identifier = identifier;
    action.title = title;
    action.activationMode = UIUserNotificationActivationModeBackground;
    action.authenticationRequired = NO;
    action.destructive = NO;
    return action;
}

@end
