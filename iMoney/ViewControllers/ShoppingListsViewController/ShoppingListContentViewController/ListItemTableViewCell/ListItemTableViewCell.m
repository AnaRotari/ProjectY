//
//  ListItemTableViewCell.m
//  iMoney
//
//  Created by Alex on 4/12/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ListItemTableViewCell.h"

@implementation ListItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCompletedItem:(BOOL)itemIsDone {
    
    if (itemIsDone) {
        [self.itemCheckBox setOn:YES];
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.itemName.text];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        self.itemName.attributedText = attributeString;
        
    } else {
        [self.itemCheckBox setOn:NO];
    }
}

@end
