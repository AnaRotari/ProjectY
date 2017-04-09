//
//  iMoneyUtils.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "iMoneyUtils.h"

@implementation iMoneyUtils

+ (void)setupAppearance {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTranslucent:YES];
    
    [[UITabBar appearance] setTintColor:RGBColor(42, 3, 70, 1)];
}

+ (UIBarButtonItem *)getNavigationButton:(NSString *)imageName target:(id)target andSelector:(SEL)action {
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 25, 25);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (NSDate *)getTodayFormatedDate {

    NSDate* currentDate = [NSDate date];
    //Convert date to yy/mm/dd
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay fromDate:currentDate];
    currentDate = [gregorian dateFromComponents:components];
    return currentDate;
}

+ (void)setStatusBarBackgroundColor:(UIColor *)color forNavigationController:(UINavigationController *)controller {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    [UIView animateWithDuration:0.3
                     animations:^{
                         controller.navigationBar.backgroundColor = color;
                         if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
                             statusBar.backgroundColor = color;
                         }
                     }];
}

+ (NSString *)formatDate:(NSDate *)dateToFormat {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterShortStyle];
    NSLocale *locale = [NSLocale currentLocale];
    [format setTimeZone:[NSTimeZone systemTimeZone]];
    [format setLocale:locale];
    
    return [format stringFromDate:dateToFormat];
}

+ (void)showAlertView:(NSString*)title withMessage:(NSString*)message {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) { }];
    
    [alert addAction:okButton];
    [[iMoneyUtils topMostController] presentViewController:alert animated:YES completion:nil];
}

+ (UIViewController*)topMostController {
    
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    return topController;
}

+ (NSString*)getUniqID {
    
    return [[NSUUID UUID] UUIDString];
}

+ (NSString *)getCategoryName:(TransactionCategory)category {
    
    switch (category) {
        case kTransactionCategoryFoodAndDrinks:
            return @"Food And Drinks";
            break;
        case kTransactionCategoryShopping:
            return @"Shopping";
            break;
        case kTransactionCategoryHousing:
            return @"Housing";
            break;
        case kTransactionCategoryTransportation:
            return @"Transportation";
            break;
        case kTransactionCategoryVechicle:
            return @"Vechicle";
            break;
        case kTransactionCategoryLifeAndEntertainments:
            return @"Life And Entertainments";
            break;
        case kTransactionCategoryPC:
            return @"PC";
            break;
        case kTransactionCategoryFinancialExpenses:
            return @"Financial Expenses";
            break;
        case kTransactionCategoryInvestments:
            return @"Investments";
            break;
        case kTransactionCategoryIncome:
            return @"Income";
            break;
        case kTransactionCategoryGregories:
            return @"Gregories";
            break;
        case kTransactionCategoryOther:
            return @"Other";
            break;
            
        default:
            break;
    }
}

+ (NSString *)getTransactionTypeName:(PaymentType)type {
    
    switch (type) {
        case kPaymentTypeCash:
            return @"Cash";
            break;
        case kPaymentTypeDebitCard:
            return @"Debit Card";
            break;
        case kPaymentTypeCreditCard:
            return @"Credit Card";
            break;
        case kPaymentTypeBankTransfer:
            return @"Bank Transfer";
            break;
        case kPaymentTypeVouvher:
            return @"Vouvher";
            break;
        case kPaymentTypeMobilePayment:
            return @"Mobile Payment";
            break;
        case kPaymentTypeWebPayment:
            return @"Web Payment";
            break;
            
        default:
            break;
    }
}

@end
