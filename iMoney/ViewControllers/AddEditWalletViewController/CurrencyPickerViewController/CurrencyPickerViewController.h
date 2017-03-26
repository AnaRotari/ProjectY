//
//  CurrencyPickerViewController.h
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CurrencyPickerViewController;

@protocol CurrencyPickerViewControllerDelegate <NSObject>

@optional

-(void)country:(CurrencyPickerViewController *)country didChangeValue:(id)value;

@end

@interface CurrencyPickerViewController : UIViewController

@property (weak, nonatomic) id<CurrencyPickerViewControllerDelegate> delegate;

@end
