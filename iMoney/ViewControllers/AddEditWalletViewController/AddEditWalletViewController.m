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
    [self uiElementsInit];
}

- (void)setControllerTitle {
    
    switch (self.walletAction) {
        case kAddWallet:
            [self setTitle:@"Add new wallet"];
            [self addNavigationButtons:NO];
            break;
        case kEditWallt:
            [self setTitle:@"Edit wallet"];
            [self addNavigationButtons:NO];
            break;
        default:
            break;
    }
}

- (void)addNavigationButtons:(BOOL)isAddNewWallet {
    
    UIImage *doneImage = [UIImage imageNamed:@"ic_checkmark"];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.bounds = CGRectMake(0, 0, 25, 25);
    [doneButton setImage:doneImage forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneNavButton = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    
    UIImage *trashImage = [UIImage imageNamed:@"ic_trash"];
    UIButton *trashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    trashButton.bounds = CGRectMake(0, 0, 25, 25);
    [trashButton setImage:trashImage forState:UIControlStateNormal];
    [trashButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *trashNavButton = [[UIBarButtonItem alloc] initWithCustomView:trashButton];
    
    if (isAddNewWallet) {
        self.navigationItem.rightBarButtonItems = @[doneNavButton];
    } else {
        self.navigationItem.rightBarButtonItems = @[doneNavButton,trashNavButton];
    }
}

- (void)uiElementsInit {
    
    self.walletSelectedColor.layer.borderWidth = 1;
    self.walletSelectedColor.layer.borderColor = RGBColor(205, 205, 205, 1).CGColor;
}

#pragma mark - Button actions

- (void)doneButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectColorButtonAction:(id)sender {
    
    ColorPickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ColorPickerViewController"];
    controller.delegate = self;
    controller.color = self.walletSelectedColor.backgroundColor;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)selectCurrencyButtonAction:(id)sender {
    
    
}

#pragma mark - ColorPickerViewControllerDelegate

- (void)setSelectedColor:(UIColor *)color {
    
    dispatch_async(dispatch_get_main_queue(), ^{
       self.walletSelectedColor.backgroundColor = color;
    });
}

@end
