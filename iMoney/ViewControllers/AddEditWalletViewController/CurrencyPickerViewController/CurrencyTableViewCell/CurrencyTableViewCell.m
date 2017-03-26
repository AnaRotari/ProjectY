//
//  CurrencyTableViewCell.m
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "CurrencyTableViewCell.h"

@implementation CurrencyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithDict:(NSDictionary *)values {
    
    NSString *imageName = values[kCurrencyCountryCode];
    NSString *countryName = values[kCurrencyCountryName];
    NSString *countryCurrencySymbolName = [NSString stringWithFormat:@"%@ - %@", values[kCurrencyCode], values[kCurrencySymbol]];
    
    self.countryFlagImage.image     = [UIImage imageNamed:imageName];
    self.countryNameLabel.text      = countryName;
    self.countryCurrencySymbol.text = countryCurrencySymbolName;
}

@end
