//
//  BudgetTableViewCell.h
//  iMoney
//
//  Created by Alex on 4/23/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BudgetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *budgetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *spentAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainAmountLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *budgetProgressView;
@property (weak, nonatomic) IBOutlet UILabel *totalBudgetAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetTypeLabel;


- (void)setupCellWithBudgetDetails:(Budget *)budget;

@end
