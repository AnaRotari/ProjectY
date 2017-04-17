//
//  RecordsCollectionViewCell.m
//  iMoney
//
//  Created by Alex on 4/17/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "RecordsCollectionViewCell.h"

@implementation RecordsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)previousButtonAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionPreviousButtonPushed)]) {
        [self.delegate collectionPreviousButtonPushed];
    }
}

- (IBAction)nextButtonAction:(UIButton *)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionNextButtonPushed)]) {
        [self.delegate collectionNextButtonPushed];
    }
}

@end
