//
//  WalletTableViewCell.m
//  iMoney
//
//  Created by Alex on 4/6/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "WalletTableViewCell.h"

@implementation WalletTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellWithWallet:(Wallet *)wallet {

    self.walletColorView.backgroundColor = [[UIColor alloc] colorWithData:wallet.walletColor];
    self.walletNameLabel.text = wallet.walletName;
    self.walletDescriptionLabel.text = wallet.walletDescription;
    self.walletCurrencyLabel.text = wallet.walletCurrency;
}

@end
