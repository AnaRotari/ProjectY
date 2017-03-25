//
//  MenuTableViewCell.m
//  iMoney
//
//  Created by Alex on 3/19/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self setTintColor:[UIColor whiteColor]];
}

- (void)initCellWithValue:(NSString *)name andImageName:(NSString *)imageName {
    
    self.nameLabel.text = name;
    self.iconImageView.image = [UIImage imageNamed:imageName];
}

@end
