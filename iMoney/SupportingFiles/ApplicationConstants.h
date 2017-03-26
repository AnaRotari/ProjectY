//
//  ApplicationConstants.h
//  Six Pack Abs
//
//  Created by Alex Overseer on 1/10/17.
//  Copyright © 2017 Softintercom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationConstants : NSObject

//Core Data constants
FOUNDATION_EXPORT NSString *const kDBiMoneySQLite;
FOUNDATION_EXPORT NSString *const kDBiMoneySQLiteSHM;
FOUNDATION_EXPORT NSString *const kDBiMoneySQLiteWAL;

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


@end
