//
//  TransactionTableViewCell.m
//  iMoney
//
//  Created by Alex on 3/25/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "TransactionTableViewCell.h"

@implementation TransactionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initTransactionCell:(Transaction *)transaction hidesDateLabel:(BOOL)hide{
    
    NSString *imageName = [NSString stringWithFormat:@"category_%d",transaction.transactionCategory];
    self.transactionCategoryImage.image = [UIImage imageNamed:imageName];
    
    self.dateLabel.text = [iMoneyUtils formatDate:transaction.transactionDate];
    hide ? [self.dateLabel setHidden:YES] : [self.dateLabel setHidden:NO];
    
    self.transactionCategoryNameLabel.text = [iMoneyUtils getCategoryName:transaction.transactionCategory];
    
    [self setTransactionType:self.transactionAmountLabel
                  withAmount:transaction.transactionAmount
                     andType:transaction.transactionType];
}

- (void)setTransactionType:(UILabel *)transactionLabel withAmount:(NSDecimalNumber *)amount andType:(TransactionType)type {
    
    switch (type) {
        case kTransactionTypeIncome:
            [transactionLabel setTextColor:[UIColor greenColor]];
            transactionLabel.text = [NSString stringWithFormat:@"+ %@",[amount stringValue]];
            break;
        case kTransactionTypeExpense:
            [transactionLabel setTextColor:[UIColor redColor]];
            transactionLabel.text = [NSString stringWithFormat:@"- %@",[amount stringValue]];
            break;
            
        default:
            break;
    }
}

@end
