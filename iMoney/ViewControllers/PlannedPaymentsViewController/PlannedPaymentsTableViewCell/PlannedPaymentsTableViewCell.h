//
//  PlannedPaymentsTableViewCell.h
//  iMoney
//
//  Created by Alex on 4/17/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlannedPaymentsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *plannedPaymentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *plannedPaymentCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *plannedPaymentAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *plannedPaymentDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *plannedPaymentFrequencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *plannedPaymentDateLabel;

- (void)initCellWithPayment:(PlannedPayments *)payment;

@end
