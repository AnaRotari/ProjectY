//
//  WarrantiesTableViewCell.m
//  iMoney
//
//  Created by Alex on 4/15/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "WarrantiesTableViewCell.h"

@implementation WarrantiesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithTransactionDetails:(Transaction *)transaction {
    
    self.warrientyDateLabel.text = [iMoneyUtils formatDate:transaction.transactionDate];
    
    double totalDays   = [self getDaysDifference:transaction.transactionDate
                                      finishDate:transaction.transactionWarrienty];
    
    double currentDays = [self getDaysDifference:transaction.transactionDate
                                      finishDate:[iMoneyUtils getTodayFormatedDate]];
    
    double progress = currentDays/totalDays;
    [self.warrientyProgress setProgress:progress];
    
    NSInteger totalNumberOfMonths = [self getMonthsDifference:transaction.transactionDate
                                                   finishDate:transaction.transactionWarrienty];
    self.totalWarrientyLabel.text = [NSString stringWithFormat:@"Warranty %ld months",totalNumberOfMonths];
    
    NSInteger numberOfMonthsRemained = [self getMonthsDifference:[iMoneyUtils getTodayFormatedDate]
                                                   finishDate:transaction.transactionWarrienty];
    
    NSInteger numberOfDaysRemaines = [self getDaysDifference:[iMoneyUtils getTodayFormatedDate]
                                               finishDate:transaction.transactionWarrienty];
    
    if (numberOfMonthsRemained == 1)
    {
        self.warrientyMonthsRemainedLabel.text = [NSString stringWithFormat:@"%ld month remaining",numberOfMonthsRemained];
    }
    else if (numberOfMonthsRemained != 0)
    {
        self.warrientyMonthsRemainedLabel.text = [NSString stringWithFormat:@"%ld months remaining",numberOfMonthsRemained];
    }
    else if (numberOfDaysRemaines == 1)
    {
        self.warrientyMonthsRemainedLabel.text = [NSString stringWithFormat:@"%ld day remaining",numberOfDaysRemaines];
    }
    else if (numberOfDaysRemaines != 0)
    {
        self.warrientyMonthsRemainedLabel.text = [NSString stringWithFormat:@"%ld days remaining",numberOfDaysRemaines];
    }
    else
    {
        self.warrientyMonthsRemainedLabel.text = @"Warrienty is over";
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

- (NSInteger)getMonthsDifference:(NSDate *)startDate finishDate:(NSDate *)finishDate {
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitMonth
                                                        fromDate:startDate
                                                          toDate:finishDate
                                                         options:0];
    return [components month];
}

@end
