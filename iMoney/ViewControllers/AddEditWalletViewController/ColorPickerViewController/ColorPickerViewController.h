//
//  ColorPickerViewController.h
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRColorPickerView.h"

@protocol ColorPickerViewControllerDelegate

- (void)setSelectedColor:(UIColor *)color;

@end

@interface ColorPickerViewController : UIViewController

@property (nonatomic, weak) IBOutlet HRColorPickerView *colorPickerView;

@property (strong, nonatomic) UIColor *color;

@property (nonatomic, weak) id <ColorPickerViewControllerDelegate> delegate;

@end
