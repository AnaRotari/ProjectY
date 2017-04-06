//
//  WalletTableViewCell.h
//  iMoney
//
//  Created by Alex on 4/6/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *walletColorView;
@property (weak, nonatomic) IBOutlet UILabel *walletNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletDescriptionLabel;

- (void)initCellWithWallet:(Wallet *)wallet;

@end
