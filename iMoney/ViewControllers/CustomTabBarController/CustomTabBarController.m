//
//  CustomTabBarController.m
//  fastFitnessUpdate
//
//  Created by Ion Postolachi on 11/10/15.
//  Copyright © 2015 Ion Postolachi. All rights reserved.
//

#import "CustomTabBarController.h"

@interface CustomTabBarController ()
@end

@implementation CustomTabBarController

int tabBarHeight = 60;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tabBar.translucent = YES;
    [self.tabBar setBackgroundImage:[UIImage new]];
    
    UIToolbar *blurredView = [[UIToolbar alloc] initWithFrame:self.tabBar.bounds];
    [blurredView setBarStyle:UIBarStyleDefault];
    [blurredView setTranslucent:YES];
    blurredView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.tabBar insertSubview:blurredView atIndex:0];
    self.navigationController.navigationBar.translucent = NO;
}

- (UIImage *)tabBarImageName:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

- (void)viewWillLayoutSubviews {
    
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = tabBarHeight;
    tabFrame.origin.y = self.view.frame.size.height - tabBarHeight;
    self.tabBar.frame = tabFrame;
}

@end
