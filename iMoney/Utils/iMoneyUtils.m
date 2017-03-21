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
}

@end
