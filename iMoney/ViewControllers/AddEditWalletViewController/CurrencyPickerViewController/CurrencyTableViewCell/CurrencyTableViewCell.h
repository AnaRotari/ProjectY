//
//  CurrencyTableViewCell.h
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countryCurrencySymbol;
@property (weak, nonatomic) IBOutlet UIImageView *countryFlagImage;
@property (weak, nonatomic) IBOutlet UILabel *countryNameLabel;

- (void)setupCellWithDict:(NSDictionary *)values;

@end
