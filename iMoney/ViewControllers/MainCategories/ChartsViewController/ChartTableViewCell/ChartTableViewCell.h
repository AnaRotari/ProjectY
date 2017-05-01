//
//  ChartTableViewCell.h
//  iMoney
//
//  Created by Alex on 4/27/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *chartNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chartPreviewImage;

@end
