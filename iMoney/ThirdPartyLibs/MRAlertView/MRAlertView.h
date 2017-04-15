//
//  MRAlertView.h
//  TopSecret
//
//  Created by Radoo on 05/03/14.
//  Copyright (c) 2014 Radoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MRAlertViewStyle)
{
    MRAlertViewStyleDefault = 0,
    MRAlertViewStylePlainTextInput
};

@class MRAlertView;
@protocol MRAlertViewDelegate <NSObject>
- (void)alertView:(MRAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface MRAlertView : UIView

@property (nonatomic, strong) id<MRAlertViewDelegate> delegate;
@property (nonatomic, assign) MRAlertViewStyle alertViewStyle;
@property (nonatomic, strong, readonly) UITextView *textView;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
- (void)show;
- (void)dismiss;


@end
