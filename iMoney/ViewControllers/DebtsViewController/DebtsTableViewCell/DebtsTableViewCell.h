//
//  DebtsTableViewCell.h
//  iMoney
//
//  Created by Alex on 4/24/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DebtsTableViewCellDelegate <NSObject>

- (void)transactionsButtonDebtsCell:(NSInteger)buttonTag;
- (void)closeDebtButtonDebtsCell:(NSInteger)buttonTag;

@end

@interface DebtsTableViewCell : UITableViewCell

@property (weak, nonatomic) id <DebtsTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *debtNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *debtRemainLabel;
@property (weak, nonatomic) IBOutlet UILabel *debtDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *debtAmountProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *debtTimeProgressView;
@property (weak, nonatomic) IBOutlet UILabel *debtStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *debtFinishDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *transactionsButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *closeDebtButtonAction;


- (void)initCellWithDebt:(Debt *)debt;

@end
