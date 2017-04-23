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
            [self addNavigationButtons:YES];
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
    
    UIBarButtonItem *doneNavButton = [iMoneyUtils getNavigationButton:@"ic_checkmark"
                                                               target:self
                                                          andSelector:@selector(doneButtonAction:)];
    if (isAddNewWallet) {
        self.navigationItem.rightBarButtonItems = @[doneNavButton];
    } else {
        UIBarButtonItem *trashNavButton = [iMoneyUtils getNavigationButton:@"ic_trash"
                                                                    target:self
                                                               andSelector:@selector(deleteButtonAction:)];
        self.navigationItem.rightBarButtonItems = @[doneNavButton,trashNavButton];
    }
}

- (void)uiElementsInit {
    
    self.walletSelectedColor.layer.borderWidth = 1;
    self.walletSelectedColor.layer.borderColor = RGBColor(205, 205, 205, 1).CGColor;
    
    if (self.walletAction == kEditWallt) {
        self.walletSelectedColor.backgroundColor = [[UIColor alloc] colorWithData:self.walletToEdit.walletColor];
        self.walletCurrencyLabel.text = self.walletToEdit.walletCurrency;
        self.walletDescriptionTextField.text = self.walletToEdit.walletDescription;
        self.walletInitValueTextField.text = [self.walletToEdit.walletBalance stringValue];
        self.walletNameTextField.text = self.walletToEdit.walletName;
    }
}

#pragma mark - Button actions

- (void)doneButtonAction:(id)sender {
    
    switch (self.walletAction) {
        case kAddWallet:
            [self addNewWalletToDB];
            break;
        case kEditWallt:
            [self updateExistingWallet];
            break;
        default:
            break;
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addNewWalletToDB {
    
    NSDictionary *newWallet = @{kWalletColor       : self.walletSelectedColor.backgroundColor,
                                kWalletCurrency    : self.walletCurrencyLabel.text,
                                kWalletDescription : self.walletDescriptionTextField.text,
                                kWalletBalance     : self.walletInitValueTextField.text,
                                kWalletName        : self.walletNameTextField.text};
    
    [CoreDataInsertManager createWallet:newWallet];
}

- (void)updateExistingWallet {
    
    NSError *error;
    self.walletToEdit.walletColor = self.walletSelectedColor.backgroundColor.encode;
    self.walletToEdit.walletCurrency = self.walletCurrencyLabel.text;
    self.walletToEdit.walletDescription = self.walletDescriptionTextField.text;
    self.walletToEdit.walletBalance = [NSDecimalNumber decimalNumberWithString:self.walletInitValueTextField.text];
    self.walletToEdit.walletName = self.walletNameTextField.text;
    if(![[[CoreDataAccessLayer sharedInstance] managedObjectContext] save:&error]) {
        NSLog(@"Cant update wallet :%@",[error localizedDescription]);
    }
}

- (void)deleteButtonAction:(id)sender {
    
    NSError *error;
    [[[CoreDataAccessLayer sharedInstance] managedObjectContext] deleteObject:self.walletToEdit];
    if(![[[CoreDataAccessLayer sharedInstance] managedObjectContext] save:&error]) {
        NSLog(@"Cant delete wallet :%@",[error localizedDescription]);
    } else {
        [CoreDataBudgetManager checkBudgetsWithoutWallets];
    }
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

- (IBAction)selectColorButtonAction:(id)sender {
    
    ColorPickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ColorPickerViewController"];
    controller.delegate = self;
    controller.color = self.walletSelectedColor.backgroundColor;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)selectCurrencyButtonAction:(id)sender {
    
    CurrencyPickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrencyPickerViewController"];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - ColorPickerViewControllerDelegate

- (void)setSelectedColor:(UIColor *)color {
    
    self.walletSelectedColor.backgroundColor = color;
}

#pragma mark - CurrencyPickerViewControllerDelegate

- (void)country:(CurrencyPickerViewController *)country didChangeValue:(id)value {
    
    self.walletCurrencyLabel.text = [value valueForKey:@"kCurrencyCode"];
}

@end
