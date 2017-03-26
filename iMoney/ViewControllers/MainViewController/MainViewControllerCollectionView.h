//
//  MainViewControllerCollectionView.h
//  iMoney
//
//  Created by Alex on 3/21/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWViewPager.h"

@protocol MainViewControllerCollectionViewDelegate <NSObject>

- (void)userDidScrollToWallet:(NSInteger)walletNumber;
- (void)userDidSelectWallet:(NSInteger)walletSelected;

@end

@interface MainViewControllerCollectionView : NSObject <UICollectionViewDataSource, HWViewPagerDelegate>

@property (nonatomic, weak) id <MainViewControllerCollectionViewDelegate> delegate;

@property (strong, nonatomic) NSArray <Wallet *> *walletsArray;

@end
