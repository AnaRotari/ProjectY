//
//  ColorPickerViewController.m
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ColorPickerViewController.h"

@implementation ColorPickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.colorPickerView.color = self.color;
    [self.colorPickerView addTarget:self
                             action:@selector(colorDidChange:)
                   forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    if (self.delegate) {
        [self.delegate setSelectedColor:self.color];
    }
}

- (void)colorDidChange:(HRColorPickerView *)colorPickerView {
    
    self.color = colorPickerView.color;
}

@end
