//
//  ReportsCollectionViewCell.h
//  iMoney
//
//  Created by Alex on 4/20/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportsCollectionViewCell : UICollectionViewCell

//Top hreni violet
@property (weak, nonatomic) IBOutlet UILabel *currentMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashflowLabelTop;

//Income
@property (weak, nonatomic) IBOutlet UILabel *incomeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeAvgDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeAvgRecordLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeTotalLabel;

//Expense
@property (weak, nonatomic) IBOutlet UILabel *expenseCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *expenseAvgDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *expenseAvgRecordLabel;
@property (weak, nonatomic) IBOutlet UILabel *expenseTotalLabel;

//Hreni de jos
@property (weak, nonatomic) IBOutlet UILabel *startingBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *netEndingBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashflowLabelBottom;


@end
