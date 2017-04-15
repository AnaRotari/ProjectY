//
//  MRAlertButton.h
//  TopSecret
//
//  Created by Radoo on 06/03/14.
//  Copyright (c) 2014 Radoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRAlertButton : UIButton

@property (nonatomic, strong) UIColor* buttonBackgroundNormalColor;
@property (nonatomic, strong) UIColor* buttonBackgroundHighlightColor;
@property (nonatomic, strong) UIColor* buttonTitleNormalColor;
@property (nonatomic, strong) UIColor* buttonTitleHighlightColor;
@property (nonatomic, assign) BOOL isCancelButton;

@end
