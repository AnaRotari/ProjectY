//
//  iMoneyUtils.h
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iMoneyUtils : NSObject

+ (void)setupAppearance;
+ (UIBarButtonItem *)getNavigationButton:(NSString *)imageName target:(id)target andSelector:(SEL)action;
+ (NSDate *)getTodayFormatedDate;
+ (void)setStatusBarBackgroundColor:(UIColor *)color forNavigationController:(UINavigationController *)controller;
+ (NSString *)formatDate:(NSDate *)dateToFormat;
+ (void)showAlertView:(NSString*)title withMessage:(NSString*)message;
+ (NSString*)getUniqID;

+ (NSString *)getCategoryName:(TransactionCategory)category;
+ (NSString *)getTransactionTypeName:(PaymentType)type;

@end
