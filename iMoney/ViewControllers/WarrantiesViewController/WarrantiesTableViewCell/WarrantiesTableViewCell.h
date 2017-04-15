//
//  WarrantiesTableViewCell.h
//  iMoney
//
//  Created by Alex on 4/15/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WarrantiesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *warrientyDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *warrientyMonthsRemainedLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *warrientyProgress;
@property (weak, nonatomic) IBOutlet UILabel *totalWarrientyLabel;


- (void)setupCellWithTransactionDetails:(Transaction *)transaction;

@end
