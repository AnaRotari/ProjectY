//
//  DebtsDetailViewController.h
//  iMoney
//
//  Created by Alex on 4/24/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewController.h"

typedef NS_ENUM(NSInteger, DebtStatus)
{
    DebtStatusAdd = 0,
    DebtStatusEdit
};

@interface DebtsDetailViewController : UIViewController <PickerViewControllerDelegate>

//Data Flow
@property (assign, nonatomic) DebtStatus debtStatus;
@property (strong, nonatomic) Debt *selectedDebt;

//UI
@property (weak, nonatomic) IBOutlet UITextField *debtNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *debtDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *debtAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *walletCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *debtTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletNameLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *supportViewCollection;

@end
