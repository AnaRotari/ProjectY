//
//  MRAlertButton.m
//  TopSecret
//
//  Created by Radoo on 06/03/14.
//  Copyright (c) 2014 Radoo. All rights reserved.
//

#import "MRAlertButton.h"

@implementation MRAlertButton

- (void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted)
    {
        self.backgroundColor = self.buttonBackgroundHighlightColor;
        [self setTitleColor: self.buttonTitleHighlightColor forState:UIControlStateNormal];
    }
    else
    {
        self.backgroundColor = self.buttonBackgroundNormalColor;
        [self setTitleColor: self.buttonTitleNormalColor forState:UIControlStateNormal];
    }
}

@end
