//
//  AddEditWalletViewController.m
//  iMoney
//
//  Created by Alex on 3/25/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "AddEditWalletViewController.h"

@interface AddEditWalletViewController ()

@end

@implementation AddEditWalletViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setControllerTitle];
}

- (void)setControllerTitle {
    
    switch (self.walletAction) {
        case kAddWallet:
            [self setTitle:@"Add new wallet"];
            break;
        case kEditWallt:
            [self setTitle:@"Edit wallet"];
            break;
        default:
            break;
    }
}

@end
