//
//  MRAlertView.m
//  TopSecret
//
//  Created by Radoo on 05/03/14.
//  Copyright (c) 2014 Radoo. All rights reserved.
//

#import "MRAlertView.h"
#import "MRAlertButton.h"

#define defaultCancelTitle @"OK"
#define textFieldLateralPadding 10.0f

#define screenRect [[UIScreen mainScreen] bounds]
#define alertViewWidth 280.0f
#define alertViewHeight 160.0f
#define alertViewCornerRadius 10.0f
#define buttonCornerRadius 0.0f
#define textFieldHeight 64.0f
#define alertViewTopAndBottomPartsHeight 40.0f
#define alertViewMiddleHeight alertViewHeight-2*alertViewTopAndBottomPartsHeight
#define messageLabelSmallerHeight 30.0f

#define kAlertAnimationDuration 0.3

#define kDefaultStyle MRSTYLE_MUSICTUBE

#define autoHideAlert YES
#define Color(r,g,b,a) [UIColor colorWithRed:(r/(float)255) green:(g/(float)255) blue:(b/(float)255) alpha:a]

CGFloat const defaultAlertAlpha = 0.6f;

@interface MRAlertView ()
{
    CGFloat middlePadding;
    NSMutableArray *buttonsArray;
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *titleBackgroundView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *buttonsView;

@property (nonatomic, strong) UIView *horizontalLineView;  //Alarm project setting, if not needed then delete

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) NSArray *otherButtons;
@property (nonatomic, assign) BOOL middlePartIsHidden;

@property (copy) NSString *titleString;
@property (copy) NSString *messageString;
@property (copy) NSString *cancelString;
@end

@implementation MRAlertView

#pragma mark - Initializations
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self)
    {
        self.titleString = title;
        self.messageString = message;
        self.cancelString = cancelButtonTitle;
        
        NSMutableArray *buttonsMutableArray = [[NSMutableArray alloc] init];
        
        id eachObject;
        va_list argumentList;
        if (otherButtonTitles)
        {
            [buttonsMutableArray addObject:otherButtonTitles];
            va_start(argumentList, otherButtonTitles);
            eachObject = va_arg(argumentList, id);
            while (eachObject != nil)
            {
                [buttonsMutableArray addObject:eachObject];
                eachObject = va_arg(argumentList, id);
            }
            va_end(argumentList);
        }
        
        self.otherButtons = [NSArray arrayWithArray:buttonsMutableArray];
        [self initBackground];
        [self initAlertView];
        [self updateUI];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    _delegate = delegate;
    return [self initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
}

- (void) initBackground
{
    self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.frame = screenRect;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
}

- (void) initAlertView
{
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertViewWidth, alertViewHeight)];
    self.alertView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    [self movePopupToCenterAnimated:NO];
    self.alertView.layer.cornerRadius = alertViewCornerRadius;
    self.alertView.layer.masksToBounds = YES;
    [self addSubview:self.alertView];
    
    [self initTitleView];
    [self initMiddleView];
    [self initButtons];
}

- (void) initTitleView
{
    if (_titleString && ![self stringIsEmpty:_titleString])
    {
        self.titleBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertViewWidth, alertViewTopAndBottomPartsHeight)];
        middlePadding = self.titleBackgroundView.frame.size.height;
        [self.alertView addSubview:self.titleBackgroundView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:self.titleBackgroundView.frame];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont fontWithName:@"SFUIText-Semibold" size:15];
        [self.titleBackgroundView addSubview:self.titleLabel];
        self.titleLabel.text = _titleString;
    }
    else
    {
        middlePadding = 0;
        [self removeTitlePartFromAlert];
    }
}

- (void) initMiddleView
{
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = [UIFont fontWithName:@"SFUIText-Semibold" size:20];
    [self.alertView addSubview:self.messageLabel];
    self.messageLabel.text = _messageString;
    
    [self addTextField];
    [self updateMiddleView];
    
    //Alarm project setting, if not needed then delete:
    self.horizontalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.alertView.frame.size.height - alertViewTopAndBottomPartsHeight - 1 / [[UIScreen mainScreen] scale] - 5, self.alertView.frame.size.width,1/[[UIScreen mainScreen] scale])];

    if (_otherButtons.count > 0)
    {
        self.horizontalLineView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.horizontalLineView.backgroundColor = Color(238, 238, 238, 225);
    }
    [self.alertView addSubview:self.horizontalLineView];
}

- (void) updateMiddleView
{
    BOOL showMessageLabel = _messageString && ![self stringIsEmpty:_messageString];
    switch (_alertViewStyle)
    {
        case MRAlertViewStyleDefault:
            _textView.hidden = YES;
            if (showMessageLabel)
            {
                self.messageLabel.frame = CGRectMake(textFieldLateralPadding, middlePadding, alertViewWidth-2*textFieldLateralPadding, alertViewMiddleHeight);
            }
            else
            {
                [self removeMiddlePartFromAlert];
            }
            break;
        case MRAlertViewStylePlainTextInput:
            [self addMiddlePartToAlert];
            if (showMessageLabel)
            {
                self.messageLabel.hidden = NO;
                self.messageLabel.frame = CGRectMake(textFieldLateralPadding, middlePadding, alertViewWidth - 2 * textFieldLateralPadding, messageLabelSmallerHeight);
                _textView.frame = CGRectMake(textFieldLateralPadding, middlePadding+messageLabelSmallerHeight, alertViewWidth - 2 * textFieldLateralPadding, textFieldHeight);
            }
            else
            {
                self.messageLabel.hidden = YES;
                _titleLabel.frame = CGRectMake(_titleLabel.frame.origin.x, 0, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
                _textView.frame = CGRectMake(textFieldLateralPadding, middlePadding+(alertViewMiddleHeight - textFieldHeight) / 2, alertViewWidth - 2 * textFieldLateralPadding, textFieldHeight);
            }
            _textView.hidden = NO;
            break;
        default:
            break;
    }
}

- (void) removeMiddlePartFromAlert
{
    if (!self.middlePartIsHidden)
    {
        self.middlePartIsHidden = YES;
        _textView.hidden = YES;
        self.messageLabel.hidden = YES;
        self.alertView.frame = CGRectMake(0, 0, alertViewWidth, self.alertView.frame.size.height - alertViewMiddleHeight);
        self.horizontalLineView.frame = CGRectMake(0, self.alertView.frame.size.height - alertViewTopAndBottomPartsHeight-1/[[UIScreen mainScreen] scale], self.alertView.frame.size.width,1/[[UIScreen mainScreen] scale]);
        self.buttonsView.frame = CGRectMake(0, self.alertView.frame.size.height - alertViewTopAndBottomPartsHeight, self.alertView.frame.size.width, alertViewTopAndBottomPartsHeight);
        self.alertView.center = self.center;
    }
}

- (void) addMiddlePartToAlert
{
    if (self.middlePartIsHidden)
    {
        self.middlePartIsHidden = NO;
        _textView.hidden = NO;
        self.messageLabel.hidden = NO;
        self.alertView.frame = CGRectMake(0, 0, alertViewWidth, self.alertView.frame.size.height+alertViewMiddleHeight);
        self.horizontalLineView.frame = CGRectMake(0, self.alertView.frame.size.height - alertViewTopAndBottomPartsHeight-1/[[UIScreen mainScreen] scale], self.alertView.frame.size.width,1/[[UIScreen mainScreen] scale]);
        self.buttonsView.frame = CGRectMake(0, self.alertView.frame.size.height - alertViewTopAndBottomPartsHeight, self.alertView.frame.size.width, alertViewTopAndBottomPartsHeight);
        self.buttonsView.frame = CGRectMake(0, self.alertView.frame.size.height - alertViewTopAndBottomPartsHeight, self.alertView.frame.size.width, alertViewTopAndBottomPartsHeight);
        self.alertView.center = self.center;
    }
}

- (void) removeTitlePartFromAlert
{
    self.alertView.frame = CGRectMake(0, 0, alertViewWidth, self.alertView.frame.size.height-alertViewTopAndBottomPartsHeight);
    self.alertView.center = self.center;
}

- (void) addTextField
{
    _textView = [[UITextView alloc] init];
    _textView.textColor = Color(76, 89, 98, 1);
    _textView.font = [UIFont fontWithName:@"SFUIText-Semibold" size:14];
    _textView.layer.cornerRadius = 5.0f;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderColor = Color(238, 238, 238, 1).CGColor;
    _textView.layer.borderWidth = 1.0f;
    _textView.keyboardType = UIKeyboardTypeDefault;
    _textView.returnKeyType = UIReturnKeyDefault;
    [self.alertView addSubview:_textView];
    [self initTextFieldNotifications];
}

- (void) initTextFieldNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditingSelector) name:UITextViewTextDidBeginEditingNotification object:_textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditingSelector) name:UITextViewTextDidEndEditingNotification object:_textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autohide) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void) initButtons
{
    self.buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.alertView.frame.size.height - alertViewTopAndBottomPartsHeight, self.alertView.frame.size.width, alertViewTopAndBottomPartsHeight)];
    [self.alertView addSubview:self.buttonsView];
    
    NSMutableArray *allButtonsArray = [[NSMutableArray alloc] init];
    
    if (_cancelString && ![self stringIsEmpty:_cancelString])
    {
        [allButtonsArray addObject:_cancelString];
    }
    
    for (NSString *buttonTitle in self.otherButtons)
    {
        if (![self stringIsEmpty:buttonTitle])
        {
            [allButtonsArray addObject:buttonTitle];
        }
    }
    
    if (allButtonsArray.count == 0)
    {
        [allButtonsArray addObject:defaultCancelTitle];
    }
    
    NSUInteger buttonsCount = [allButtonsArray count];
    CGFloat buttonPadding = 0;
    CGFloat buttonWidth = (self.buttonsView.frame.size.width - buttonPadding * (buttonsCount + 1)) / buttonsCount;
    
    buttonsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < buttonsCount; i++)
    {
        NSString *buttonTitle = allButtonsArray[i];
        MRAlertButton *button = [MRAlertButton buttonWithType:UIButtonTypeCustom];
        button.isCancelButton = (i == 0);
        button.frame = CGRectMake(i * buttonWidth + (i + 1) * buttonPadding, buttonPadding, buttonWidth, self.buttonsView.frame.size.height - buttonPadding * 2);
        button.tag = i;
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"SFUIText-Semibold" size:14];
        button.layer.cornerRadius = buttonCornerRadius;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(alertButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsView addSubview:button];
        [buttonsArray addObject:button];
    }
}

#pragma mark - Alert Behaviour Methods
- (void)show
{
    UIWindow *mainWindow = [[UIApplication sharedApplication] windows][0];
    [mainWindow endEditing:YES];
    [mainWindow addSubview:self];
    [self animateAlertShow];
}

- (void) dismiss
{
    [self dismissAnimated:YES];
}

- (void)dismissAnimated:(BOOL) animated
{
    [self dismissKeyboardIfNeeded];
    if (animated)
    {
        self.alpha = 1.0f;
        [UIView animateWithDuration:kAlertAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void) {
                             self.alpha = 0.0f;
                         }
                         completion:^(BOOL finished){ [self removeFromSuperview]; }];
    }
    else
    {
        [self removeFromSuperview];
    }
}

- (void) setAlertViewStyle:(MRAlertViewStyle)alertViewStyle
{
    _alertViewStyle = alertViewStyle;
    [self updateMiddleView];
}

- (void) showKeyboardIfNeeded
{
    if (_alertViewStyle == MRAlertViewStylePlainTextInput)
    {
        [_textView becomeFirstResponder];
    }
}

- (void) dismissKeyboardIfNeeded
{
    if (_alertViewStyle == MRAlertViewStylePlainTextInput)
    {
        [_textView resignFirstResponder];
    }
}

- (void)alertButtonPressed:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
    {
        [self.delegate alertView:self clickedButtonAtIndex:button.tag];
    }
    [self dismiss];
}

- (void) autohide
{
    if (autoHideAlert)
    {
        [self dismissAnimated:NO];
    }
}

#pragma mark - Animations Methods
-(void) animateAlertShow
{
    _alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    _alertView.alpha = 1.0;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:kAlertAnimationDuration+0.1 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:defaultAlertAlpha];
    } completion: ^(BOOL finished) {}];
    
    [UIView animateWithDuration:kAlertAnimationDuration/1.5
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         _alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
                     }
                     completion:^(BOOL finished){ [self firstBounceAnimationStopped]; }];
}

- (void) firstBounceAnimationStopped
{
    [UIView animateWithDuration:kAlertAnimationDuration/2
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         _alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
                     }
                     completion:^(BOOL finished){ [self secondBounceAnimationStopped]; }];
}

- (void) secondBounceAnimationStopped
{
    [UIView animateWithDuration:kAlertAnimationDuration/2
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         _alertView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished){ [self showKeyboardIfNeeded]; }];
}

- (void) movePopupToCenterAnimated:(BOOL) animated
{
    if (animated)
    {
        [UIView animateWithDuration:kAlertAnimationDuration animations:^{
            _alertView.center = self.center;
        } completion: ^(BOOL finished) {}];
    }
    else
    {
        _alertView.center = self.center;
    }
}

- (void) movePopupToTopAnimated:(BOOL) animated
{
    CGFloat kKeyboardPortraitHeight = 216.0f;
    if (animated)
    {
        [UIView animateWithDuration:kAlertAnimationDuration animations:^{
            _alertView.center = CGPointMake(self.bounds.size.width / 2, (self.bounds.size.height-kKeyboardPortraitHeight)/2);
        } completion: ^(BOOL finished) {}];
    }
    else
    {
        _alertView.center = CGPointMake(self.bounds.size.width / 2, (self.bounds.size.height-kKeyboardPortraitHeight)/2);
    }
}

#pragma mark - Text Field Notifications
- (void) textFieldDidBeginEditingSelector
{
    [self movePopupToTopAnimated:YES];
}

- (void) textFieldDidEndEditingSelector
{
    [self movePopupToCenterAnimated:YES];
}

- (void) textFieldReturnButtonPressed
{
    [self dismissKeyboardIfNeeded];
}

#pragma mark - Update UI
- (void) updateUI
{
    self.titleBackgroundView.backgroundColor = [UIColor whiteColor];
    self.titleLabel.textColor = Color(76, 89, 98, 1);
    self.alertView.backgroundColor = [UIColor whiteColor];
    self.messageLabel.textColor = Color(76, 89, 98, 1);
    self.buttonsView.backgroundColor = [UIColor whiteColor];
    _textView.tintColor = Color(30, 162, 227, 1);
    
    for (MRAlertButton *button in buttonsArray)
    {
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:Color(30, 162, 227, 1) forState:UIControlStateNormal];
        button.buttonBackgroundNormalColor = [UIColor clearColor];
        button.buttonBackgroundHighlightColor = [UIColor whiteColor];
        button.buttonTitleNormalColor = Color(30, 162, 227, 1);
        button.buttonTitleHighlightColor = Color(76, 89, 98, 1);
    }
}

#pragma mark - Text Formatting
- (BOOL) stringIsEmpty:(NSString*) str
{
    return ([str stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0);
}

#pragma mark - Deallocations
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

@end
