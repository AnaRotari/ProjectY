//
//  AddEditWalletViewController.h
//  iMoney
//
//  Created by Alex on 3/25/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPickerViewController.h"
#import "CurrencyPickerViewController.h"

@interface AddEditWalletViewController : UIViewController <ColorPickerViewControllerDelegate,CurrencyPickerViewControllerDelegate>

//Data Flow
@property (assign, nonatomic) AddEditWallet walletAction;
@property (strong, nonatomic) Wallet *walletToEdit;

@property (weak, nonatomic) IBOutlet UITextField *walletDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *walletNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *walletInitValueTextField;
@property (weak, nonatomic) IBOutlet UILabel *walletCurrencyLabel;
@property (weak, nonatomic) IBOutlet UIView *walletSelectedColor;

@end
