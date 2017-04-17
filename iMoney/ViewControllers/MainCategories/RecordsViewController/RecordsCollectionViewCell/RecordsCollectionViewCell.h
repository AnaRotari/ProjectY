//
//  RecordsCollectionViewCell.h
//  iMoney
//
//  Created by Alex on 4/17/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecordsCollectionViewCellDelegate <NSObject>

@optional
- (void)collectionNextButtonPushed;
- (void)collectionPreviousButtonPushed;

@end

@interface RecordsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id <RecordsCollectionViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *balancePeriodLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashflowLabel;

- (IBAction)previousButtonAction:(UIButton *)sender;
- (IBAction)nextButtonAction:(UIButton *)sender;

@end
