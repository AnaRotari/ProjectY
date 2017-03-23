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
    
    NSArray *array = @[@{@"title" : @"Exercises", @"image" : @"exercises", @"selectedImage" : @"exercises_"},
                       @{@"title" : @"Workouts", @"image" : @"training", @"selectedImage" : @"training_"},
                       @{@"title" : @"Custom", @"image" : @"customized", @"selectedImage" : @"customized_"},
                       @{@"title" : @"History", @"image" : @"history", @"selectedImage" : @"history_"},
                       @{@"title" : @"More", @"image" : @"more", @"selectedImage" : @"more_"}];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[self.tabBar.items objectAtIndex:idx] setTitle:NSLocalizedString(obj[@"title"], nil)];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self.tabBar.items objectAtIndex:idx] setImage:[self tabBarImageName:obj[@"image"]]];
            [[self.tabBar.items objectAtIndex:idx] setSelectedImage:[self tabBarImageName:obj[@"selectedImage"]]];
        });
    }];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : RGBColor(42, 3, 70, 1) }
                                             forState:UIControlStateSelected];
    
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
