//
//  MainViewController.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MainViewController.h"
#import "HWViewPager.h"

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, HWViewPagerDelegate>

@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property (weak, nonatomic) IBOutlet HWViewPager *walletsCollectionView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customSetup];
}

#pragma mark - UICollectionViewDataSource

/*
 SectionInset = 0,0,0,0
 minimumLineSpacint = 0
 For Full Layout Pager
 */

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FullCollectionCell" forIndexPath:indexPath];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}


#pragma mark - UICollectionViewDelegate


#pragma mark - HWViewPagerDelegate

- (void)pagerDidSelectedPage:(NSInteger)selectedPage {
    
    NSLog(@"FistViewController, SelectedPage : %d",(int)selectedPage);
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
