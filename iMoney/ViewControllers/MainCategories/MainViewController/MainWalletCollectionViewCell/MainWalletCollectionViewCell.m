//
//  MainWalletCollectionViewCell.m
//  iMoney
//
//  Created by Alex on 3/23/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MainWalletCollectionViewCell.h"

@implementation MainWalletCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.layer.cornerRadius = 10;
    
}

- (void)initWalletWithData:(Wallet *)walletData {
    
    self.backgroundColor = [[UIColor alloc] colorWithData:walletData.walletColor];
    self.walletNameLabel.text = walletData.walletName;
    self.walletCurrencyLabel.text = walletData.walletCurrency;
    self.walletBalanceLabel.text = [NSString stringWithFormat:@"%.2f",walletData.walletBalance.doubleValue];
    self.walletDescriptionLabel.text = walletData.walletDescription;
}

@end
