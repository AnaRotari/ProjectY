//
//  MainViewController.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MainViewController.h"
#import "HWViewPager.h"
#import "MainViewControllerCollectionView.h"

@interface MainViewController ()

@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property (weak, nonatomic) IBOutlet HWViewPager *walletsCollectionView;
@property (strong, nonatomic) MainViewControllerCollectionView *collectionDelegates;

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customSetup];
    [self mainCollectionViewSetup];
    [self mainTableViewSetup];
}

#pragma mark - Initializations

- (void)mainCollectionViewSetup {
    
    self.collectionDelegates = [[MainViewControllerCollectionView alloc] init];
    [self.walletsCollectionView registerNib:[UINib nibWithNibName:@"MainWalletCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MainWalletCollectionViewCell"];
    //[self.walletsCollectionView setContentInset:UIEdgeInsetsMake(-70, 0, 0, 0)];
    [self.walletsCollectionView setDataSource: self.collectionDelegates];
    [self.walletsCollectionView setPagerDelegate:self.collectionDelegates];
}

- (void)mainTableViewSetup {
    
    
}

#pragma mark - Other stuff

- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController)
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector(revealToggle:)];
        [self.navigationController.navigationBar addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

@end
