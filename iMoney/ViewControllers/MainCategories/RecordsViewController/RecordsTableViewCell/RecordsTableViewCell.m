//
//  RecordsTableViewCell.m
//  iMoney
//
//  Created by Alex on 4/17/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "RecordsTableViewCell.h"

@implementation RecordsTableViewCell{
    __weak IBOutlet UIImageView *tImageView;
    __weak IBOutlet UILabel *tType;
    __weak IBOutlet UILabel *tDescription;
    __weak IBOutlet UILabel *tPaymentType;
    __weak IBOutlet UILabel *tDate;
    __weak IBOutlet UILabel *tAmount;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTransaction:(Transaction *)transaction{
    NSString *imageName = [NSString stringWithFormat:@"category_%d",transaction.transactionCategory];
    [tImageView setImage:[UIImage imageNamed:imageName]];
    
    [self setTransactionType:tAmount
        transactionTypeLabel:tPaymentType
                  withAmount:transaction.transactionAmount
                     andType:transaction.transactionType
                      wallet:transaction.wallet];
    
    tDescription.text = transaction.transactionDescription;
    tType.text = [iMoneyUtils getCategoryName:transaction.transactionCategory];
    tDate.text = [iMoneyUtils formatDate:transaction.transactionDate];
}

- (void)setTransactionType:(UILabel *)transactionLabel transactionTypeLabel:(UILabel *)transactionTypeLabel withAmount:(NSDecimalNumber *)amount andType:(TransactionType)type wallet:(Wallet *)wallet{
    
    switch (type) {
        case kTransactionTypeIncome:
            [transactionLabel setTextColor:[UIColor greenColor]];
            transactionLabel.text = [NSString stringWithFormat:@"+ %@ %@",wallet.walletCurrency, [amount stringValue]];
            transactionTypeLabel.text = @"Income";
            break;
        case kTransactionTypeExpense:
            [transactionLabel setTextColor:[UIColor redColor]];
            transactionLabel.text = [NSString stringWithFormat:@"- %@ %@",wallet.walletCurrency, [amount stringValue]];
            transactionTypeLabel.text = @"Expense";
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
