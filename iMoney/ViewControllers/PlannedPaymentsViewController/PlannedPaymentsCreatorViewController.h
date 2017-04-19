//
//  PlannedPaymentsCreatorViewController.h
//  iMoney
//
//  Created by Alex on 4/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "PickerViewController.h"

@interface PlannedPaymentsCreatorViewController : BaseViewController <PickerViewControllerDelegate>

//Data flow
@property (strong, nonatomic) PlannedPayments *plannedPayment;

//Outlets
@property (weak, nonatomic) IBOutlet UITextField *plannedNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *plannedDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *plannedAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *plannedCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *plannedTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *planedFromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *plannedFrequencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *plannedWalletLabel;

@end
