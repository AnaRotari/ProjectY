//
//  BudgetTableViewCell.m
//  iMoney
//
//  Created by Alex on 4/23/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BudgetTableViewCell.h"

@implementation BudgetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithBudgetDetails:(Budget *)budget {
    
    self.budgetNameLabel.text = budget.budgetName;
    self.finishDateLabel.text = [NSString stringWithFormat:@"Due %@",[iMoneyUtils formatDate:budget.budgetFinishDate]];
    
    NSArray <Wallet *> *walletsArray = [[NSArray alloc] initWithArray:[budget.wallets allObjects]];
    
    self.spentAmountLabel.text = [NSString stringWithFormat:@"Spent %.2f %@",budget.budgetCurrentAmount.doubleValue, [walletsArray firstObject].walletCurrency];
    
    self.remainAmountLabel.text = [NSString stringWithFormat:@"Remains %.2f %@",budget.budgetTotalAmount.doubleValue - budget.budgetCurrentAmount.doubleValue, [walletsArray firstObject].walletCurrency];
    
    self.totalBudgetAmountLabel.text = [NSString stringWithFormat:@"%@ %.2f",[walletsArray firstObject].walletCurrency,budget.budgetTotalAmount.doubleValue];
    
    switch (budget.budgetInterval) {
        case BudgetIntervalWeekly:
            self.budgetTypeLabel.text = @"Weekly";
            break;
        case BudgetIntervalMonthly:
            self.budgetTypeLabel.text = @"Monthly";
            break;
        case BudgetIntervalYearly:
            self.budgetTypeLabel.text = @"Yearly";
            break;
        default:
            break;
    }
    
    double progress = budget.budgetCurrentAmount.doubleValue / budget.budgetTotalAmount.doubleValue;
    self.budgetProgressView.progress = progress;
    if (progress > 1) {
        self.budgetProgressView.progressTintColor = [UIColor redColor];
        self.remainAmountLabel.text = @"The budget is over";
    }
}

@end
