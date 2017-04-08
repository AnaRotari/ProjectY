//
//  MainWalletCollectionViewCell.h
//  iMoney
//
//  Created by Alex on 3/23/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainWalletCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *walletNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletDescriptionLabel;

- (void)initWalletWithData:(Wallet *)walletData;

@end
