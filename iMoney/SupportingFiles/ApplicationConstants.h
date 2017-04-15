//
//  ApplicationConstants.h
//  Six Pack Abs
//
//  Created by Alex Overseer on 1/10/17.
//  Copyright © 2017 Softintercom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationConstants : NSObject

FOUNDATION_EXPORT NSString *const kFirstAppRun;

FOUNDATION_EXPORT NSString *const kAppFolder;

//Export CoreData constants
FOUNDATION_EXPORT NSString *const kDBiMoneySQLite;
FOUNDATION_EXPORT NSString *const kDBiMoneySQLiteSHM;
FOUNDATION_EXPORT NSString *const kDBiMoneySQLiteWAL;

FOUNDATION_EXPORT NSString *const kUserName;

//Currency constants
FOUNDATION_EXPORT NSString *const kCurrencyCountryName;
FOUNDATION_EXPORT NSString *const kCurrencyCountryCode;
FOUNDATION_EXPORT NSString *const kCurrencySymbol;
FOUNDATION_EXPORT NSString *const kCurrencyCode;

//Wallet constants
FOUNDATION_EXPORT NSString *const kWalletColor;
FOUNDATION_EXPORT NSString *const kWalletCurrency;
FOUNDATION_EXPORT NSString *const kWalletDescription;
FOUNDATION_EXPORT NSString *const kWalletID;
FOUNDATION_EXPORT NSString *const kWalletBalance;
FOUNDATION_EXPORT NSString *const kWalletName;

//Transaction constants
FOUNDATION_EXPORT NSString *const kTransactionAmount;
FOUNDATION_EXPORT NSString *const kTransactionAttachemts;
FOUNDATION_EXPORT NSString *const kTransactionCategory;
FOUNDATION_EXPORT NSString *const kTransactionDate;
FOUNDATION_EXPORT NSString *const kTransactionDescription;
FOUNDATION_EXPORT NSString *const kTransactionLatitude;
FOUNDATION_EXPORT NSString *const kTransactionLongitude;
FOUNDATION_EXPORT NSString *const kTransactionPayee;
FOUNDATION_EXPORT NSString *const kTransactionPaymentType;
FOUNDATION_EXPORT NSString *const kTransactionType;
FOUNDATION_EXPORT NSString *const kTransactionWarrienty;

//Reminder
FOUNDATION_EXPORT NSString *const kDailyReminder;
FOUNDATION_EXPORT NSString *const kInactivityReminder;
FOUNDATION_EXPORT NSString *const kInactivityLenght;
FOUNDATION_EXPORT NSString *const kDailySwitchState;
FOUNDATION_EXPORT NSString *const kAfterNDaysSwitchState;

@end
