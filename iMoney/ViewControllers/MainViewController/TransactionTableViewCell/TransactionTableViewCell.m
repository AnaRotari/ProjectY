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
    
    self.transactionCategoryNameLabel.text = [self getCategoryName:transaction.transactionCategory];
    
    [self setTransactionType:self.transactionAmountLabel
                  withAmount:transaction.transactionAmount
                     andType:transaction.transactionType];
}

- (NSString *)getCategoryName:(TransactionCategory)category {

    switch (category) {
        case kTransactionCategoryFoodAndDrinks:
            return @"Food And Drinks";
            break;
        case kTransactionCategoryShopping:
            return @"Shopping";
            break;
        case kTransactionCategoryHousing:
            return @"Housing";
            break;
        case kTransactionCategoryTransportation:
            return @"Transportation";
            break;
        case kTransactionCategoryVechicle:
            return @"Vechicle";
            break;
        case kTransactionCategoryLifeAndEntertainments:
            return @"Life And Entertainments";
            break;
        case kTransactionCategoryPC:
            return @"PC";
            break;
        case kTransactionCategoryFinancialExpenses:
            return @"Financial Expenses";
            break;
        case kTransactionCategoryInvestments:
            return @"Investments";
            break;
        case kTransactionCategoryIncome:
            return @"Income";
            break;
        case kTransactionCategoryGregories:
            return @"Gregories";
            break;
        case kTransactionCategoryOther:
            return @"Other";
            break;
            
        default:
            break;
    }
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
