//
//  ReminderViewController.h
//  iBodybuilding-Update-Woman
//
//  Created by Alex Overseer on 2/20/17.
//  Copyright © 2017 com.softintercom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

//Set Time Outlets
@property (weak, nonatomic) IBOutlet UIView *setTimeView;
@property (weak, nonatomic) IBOutlet UIButton *setTimeCancelButton;
@property (weak, nonatomic) IBOutlet UIButton *setTimeDoneButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *setTimeReminderPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *setTimeInactiveDayPicker;

//edit notification permissions
@property (weak, nonatomic) IBOutlet UIButton *editNotificationPermissionButton;

//Daily reminder
@property (weak, nonatomic) IBOutlet UILabel *dailyReminderLabel;
@property (weak, nonatomic) IBOutlet UIButton *dailyHourButton;
@property (weak, nonatomic) IBOutlet UISwitch *dailySwitch;

//After N Days of inactivity
@property (weak, nonatomic) IBOutlet UILabel *afterNDaysLabel;
@property (weak, nonatomic) IBOutlet UISwitch *afterNDaysSwitch;
@property (weak, nonatomic) IBOutlet UIButton *afterNDaysButton;
@property (weak, nonatomic) IBOutlet UILabel *afterNDaysFrequencyLabel;
@property (weak, nonatomic) IBOutlet UIButton *afterNDaysInactivityButton;

//properties
@property (assign, nonatomic) UIPickerType pickerType;
@property (weak, nonatomic) IBOutlet UIToolbar *coverView;

@end
