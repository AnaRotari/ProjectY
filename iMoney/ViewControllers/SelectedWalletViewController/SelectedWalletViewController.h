//
//  SelectedWalletViewController.h
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPlusButtonsView.h"
#import "TransactionViewController.h"

@interface SelectedWalletViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewNavBar;
@property (strong, nonatomic) Wallet *selectedWallet;

@end
