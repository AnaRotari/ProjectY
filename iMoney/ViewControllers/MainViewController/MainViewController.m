//
//  MainViewController.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customSetup];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector(revealToggle:)];
        [self.navigationController.navigationBar addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

@end
