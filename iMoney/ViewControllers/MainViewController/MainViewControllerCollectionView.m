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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.walletsArray = [NSArray array];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainWalletCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainWalletCollectionViewCell" forIndexPath:indexPath];
    [cell initWalletWithData:self.walletsArray[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.walletsArray.count;
}

#pragma mark - HWViewPagerDelegate

- (void)pagerDidSelectedPage:(NSInteger)selectedPage {
    
    if ([self.delegate respondsToSelector:@selector(userDidScrollToWallet:)]) {
        [self.delegate userDidScrollToWallet:selectedPage];
    }
}

- (void)pagerDidSelectItem:(NSIndexPath *)selectedItemPath {
    
    if ([self.delegate respondsToSelector:@selector(userDidSelectWallet:)]) {
        [self.delegate userDidSelectWallet:selectedItemPath.row];
    }
}

@end
