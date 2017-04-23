//
//  ReportsCollectionViewCell.h
//  iMoney
//
//  Created by Alex on 4/20/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReportsCollectionViewCellDelegate <NSObject>

@optional
- (void)collectionNextButtonPushed;
- (void)collectionPreviousButtonPushed;

@end

@interface ReportsCollectionViewCell : UICollectionViewCell

@property(weak, nonatomic) id<ReportsCollectionViewCellDelegate> delegate;

//Top hreni violet
@property (weak, nonatomic) IBOutlet UILabel *currentMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashflowLabelTop;

@end
