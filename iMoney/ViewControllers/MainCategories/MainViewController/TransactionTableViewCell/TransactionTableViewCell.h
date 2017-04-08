//
//  TransactionTableViewCell.h
//  iMoney
//
//  Created by Alex on 3/25/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *transactionCategoryImage;
@property (weak, nonatomic) IBOutlet UILabel *transactionCategoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)initTransactionCell:(Transaction *)transaction hidesDateLabel:(BOOL)hide;

@end
