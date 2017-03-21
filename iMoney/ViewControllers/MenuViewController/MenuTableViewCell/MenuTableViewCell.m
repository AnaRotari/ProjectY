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
    // Initialization code
}

- (void)initCellWithValue:(NSString *)name {
    
    self.nameLabel.text = name;
}

@end
