//
//  PlannedPaymentsTableViewCell.m
//  iMoney
//
//  Created by Alex on 4/17/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "PlannedPaymentsTableViewCell.h"

@implementation PlannedPaymentsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellWithPayment:(PlannedPayments *)payment {
    
    self.plannedPaymentNameLabel.text = payment.plannedName;
    self.plannedPaymentDescriptionLabel.text = payment.plannedDescription;
    self.plannedPaymentDateLabel.text = [iMoneyUtils formatDate:payment.plannedDate];
    self.plannedPaymentCategoryLabel.text = [iMoneyUtils getCategoryName:payment.plannedCategory];
    self.plannedPaymentFrequencyLabel.text = [iMoneyUtils getPlannedFrequencyName:payment.plannedFrequency];
    
    [self setTransactionType:self.plannedPaymentAmountLabel
                  withAmount:payment.plannedAmount
              walletCurrency:payment.wallet.walletCurrency
                     andType:payment.plannedType];
}

- (void)setTransactionType:(UILabel *)transactionLabel
                withAmount:(NSDecimalNumber *)amount
            walletCurrency:(NSString *)currency
                   andType:(TransactionType)type {
    
    switch (type) {
        case kTransactionTypeIncome:
            [transactionLabel setTextColor:[UIColor greenColor]];
            transactionLabel.text = [NSString stringWithFormat:@"+%@ %@",currency,[amount stringValue]];
            break;
        case kTransactionTypeExpense:
            [transactionLabel setTextColor:[UIColor redColor]];
            transactionLabel.text = [NSString stringWithFormat:@"-%@ %@",currency,[amount stringValue]];
            break;
            
        default:
            break;
    }
}

@end
