//
//  ReportsCollectionViewCell.m
//  iMoney
//
//  Created by Alex on 4/20/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ReportsCollectionViewCell.h"

@implementation ReportsCollectionViewCell

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
