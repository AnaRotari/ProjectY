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

@end
