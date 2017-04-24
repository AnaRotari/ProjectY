//
//  DebtsTableViewCell.m
//  iMoney
//
//  Created by Alex on 4/24/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "DebtsTableViewCell.h"

@implementation DebtsTableViewCell

- (void)initCellWithDebt:(Debt *)debt {
    
    self.debtNameLabel.text = debt.debtName;
    self.debtDescriptionLabel.text = debt.debtDescription;
    self.debtStartDateLabel.text = [NSString stringWithFormat:@"%@",[iMoneyUtils formatDate:debt.debtStartDate]];
    self.debtFinishDateLabel.text = [NSString stringWithFormat:@"%@",[iMoneyUtils formatDate:debt.debtFinishDate]];
    
    double totalDays   = [self getDaysDifference:debt.debtStartDate
                                      finishDate:debt.debtFinishDate];
    
    double currentDays = [self getDaysDifference:debt.debtStartDate
                                      finishDate:[iMoneyUtils getTodayFormatedDate]];
    
    self.debtRemainLabel.text = [NSString stringWithFormat:@"Remains: %.2f %@",debt.debtTotalAmount.doubleValue - debt.debtCurrentAmount.doubleValue, debt.wallet.walletCurrency];
    
    double timeProgress = currentDays/totalDays;
    [self.debtTimeProgressView setProgress:timeProgress];
    
    double amountProgress = debt.debtCurrentAmount.doubleValue / debt.debtTotalAmount.doubleValue;
    self.debtAmountProgressView.progress = amountProgress;
    
    if (timeProgress >= 1 && amountProgress >= 1) {
        self.debtTimeProgressView.progressTintColor = [UIColor greenColor];
    }

    if (amountProgress >= 1) {
        self.debtAmountProgressView.progressTintColor = [UIColor greenColor];
    }
}

- (NSInteger)getDaysDifference:(NSDate *)startDate finishDate:(NSDate *)finishDate {
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:finishDate
                                                         options:0];
    return [components day];
}

#pragma mark - Delegates

- (IBAction)transactionsButtonAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(transactionsButtonDebtsCell:)]) {
        [self.delegate transactionsButtonDebtsCell:sender.tag];
    }
}

- (IBAction)closeDebtButtonAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(closeDebtButtonDebtsCell:)]) {
        [self.delegate closeDebtButtonDebtsCell:sender.tag];
    }
}

@end
