//
//  SelectedWalletViewController+UI.m
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "SelectedWalletViewController+UI.h"

@implementation SelectedWalletViewController (UI)

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.navigationController.navigationBar.backgroundColor = color;
                         if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
                             statusBar.backgroundColor = color;
                         }
                     }];
}

- (void)setupLGNavButton:(LGPlusButtonsView *)button andButtonBackgroundColor:(UIColor *)color {
    
    button.showHideOnScroll = NO;
    button.appearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolveAndPop;
    button.position = LGPlusButtonsViewPositionTopRight;
    
    [button setButtonsTitles:@[@"1", @"2", @"3", @"4"] forState:UIControlStateNormal];
    [button setDescriptionsTexts:@[@"New record", @"Transfer", @"Choose template", @"Adjust balance"]];
    
    [button setButtonsTitleFont:[UIFont boldSystemFontOfSize:32.f] forOrientation:LGPlusButtonsViewOrientationAll];
    [button setButtonsSize:CGSizeMake(52.f, 52.f) forOrientation:LGPlusButtonsViewOrientationAll];
    [button setButtonsLayerCornerRadius:52.f/2.f forOrientation:LGPlusButtonsViewOrientationAll];
    [button setButtonsBackgroundColor:color forState:UIControlStateNormal];
    [button setButtonsBackgroundColor:color forState:UIControlStateHighlighted];
    [button setButtonsLayerShadowColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.f]];
    [button setButtonsLayerShadowOpacity:0.5];
    [button setButtonsLayerShadowRadius:3.f];
    [button setButtonsLayerShadowOffset:CGSizeMake(0.f, 2.f)];
    
    [button setDescriptionsTextColor:[UIColor whiteColor]];
    [button setDescriptionsBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.66]];
    [button setDescriptionsLayerCornerRadius:6.f forOrientation:LGPlusButtonsViewOrientationAll];
    [button setDescriptionsContentEdgeInsets:UIEdgeInsetsMake(4.f, 8.f, 4.f, 8.f) forOrientation:LGPlusButtonsViewOrientationAll];
}

- (void)disableSwipe {
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

@end
