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

@property (strong, nonatomic) PlannedPayments *plannedPayment;

@end
