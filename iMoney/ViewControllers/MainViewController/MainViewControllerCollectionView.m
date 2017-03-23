//
//  MainViewControllerCollectionView.m
//  iMoney
//
//  Created by Alex on 3/21/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MainViewControllerCollectionView.h"
#import "MainWalletCollectionViewCell.h"

@implementation MainViewControllerCollectionView

#pragma mark - UICollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainWalletCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainWalletCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

#pragma mark - HWViewPagerDelegate

- (void)pagerDidSelectedPage:(NSInteger)selectedPage {
    
    NSLog(@"FistViewController, SelectedPage : %d",(int)selectedPage);
}

@end
