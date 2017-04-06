//
//  ReminderViewController.m
//  iBodybuilding-Update-Woman
//
//  Created by Alex Overseer on 2/20/17.
//  Copyright © 2017 com.softintercom. All rights reserved.
//

#import "ReminderViewController.h"

@interface ReminderViewController () {
    
    NSDate *dailyDate;
    NSDate *inactivityDate;
    NSInteger inactivityLenght;
    CGRect tabBarInitialFrame;
}

@end

@implementation ReminderViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self registerNotificationPersmissions];
    [self locaizeUI];
    [self defaultSwitchState];
    tabBarInitialFrame = self.tabBarController.tabBar.frame;
    [self fitEditNotificationPermissionButton];
    
    [iMoneyUtils setStatusBarBackgroundColor:RGBColor(239, 239, 244, 1)
                     forNavigationController:self.navigationController];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self checkNotificationButton];
    [self defaulValuesForReminder];
    [self showTabBar:NO animationDuration:0.4f];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self showTabBar:YES animationDuration:0.2f];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [iMoneyUtils setStatusBarBackgroundColor:RGBColor(42, 3, 70, 1)
                     forNavigationController:self.navigationController];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    [self hideTimeView];
}

#pragma mark - Initializations

- (void)fitEditNotificationPermissionButton {
    
    self.editNotificationPermissionButton.titleLabel.numberOfLines = 1;
    self.editNotificationPermissionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.editNotificationPermissionButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
}

- (void)registerNotificationPersmissions {
    
    UIUserNotificationType notificationTypes = (UIUserNotificationType) (UIUserNotificationTypeBadge |UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:notificationTypes
                                                                                         categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
}

- (void)defaulValuesForReminder {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    //Daily notification
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kDailyReminder])
    {
        NSString *dailyButtonTitle = [dateFormatter stringFromDate:[[NSUserDefaults standardUserDefaults] objectForKey:kDailyReminder]];
        [self.dailyHourButton setTitle:dailyButtonTitle forState:UIControlStateNormal];
        dailyDate = [[NSUserDefaults standardUserDefaults] objectForKey:kDailyReminder];
    }
    else
    {
        NSString *dailyButtonTitle = [dateFormatter stringFromDate:self.setTimeReminderPicker.date];
        [self.dailyHourButton setTitle:dailyButtonTitle forState:UIControlStateNormal];
        dailyDate = self.setTimeReminderPicker.date;
    }
    
    //Inactivity notification
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kInactivityReminder])
    {
        NSString *afterNDaysTitle = [dateFormatter stringFromDate:[[NSUserDefaults standardUserDefaults] objectForKey:kInactivityReminder]];
        [self.afterNDaysButton setTitle:afterNDaysTitle forState:UIControlStateNormal];
        inactivityDate = [[NSUserDefaults standardUserDefaults] objectForKey:kInactivityReminder];
    }
    else
    {
        NSString *afterNDaysTitle = [dateFormatter stringFromDate:self.setTimeReminderPicker.date];
        [self.afterNDaysButton setTitle:afterNDaysTitle forState:UIControlStateNormal];
        inactivityDate = self.setTimeReminderPicker.date;
    }
    
    //Inactivity length notification
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kInactivityLenght])
    {
        inactivityLenght = [[NSUserDefaults standardUserDefaults] integerForKey:kInactivityLenght];
    }
    else
    {
        inactivityLenght = 1;
    }
    
    [self.setTimeInactiveDayPicker selectRow:inactivityLenght-1 inComponent:0 animated:YES];
    self.afterNDaysLabel.text = [NSString stringWithFormat:@"After %ld days of inactivity",inactivityLenght];
    [self.afterNDaysInactivityButton setTitle:[NSString stringWithFormat:@"%ld",(long)inactivityLenght] forState:UIControlStateNormal];
}

#pragma mark - Functional methods

- (void)checkNotificationButton {
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)])
    {
        UIUserNotificationSettings *grantedSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (grantedSettings.types == UIUserNotificationTypeNone)
        {
            self.editNotificationPermissionButton.hidden = NO;
        }
        else if (grantedSettings.types & UIUserNotificationTypeSound & UIUserNotificationTypeAlert)
        {
            self.editNotificationPermissionButton.hidden = NO;
        }
        else if (grantedSettings.types  & UIUserNotificationTypeAlert)
        {
            self.editNotificationPermissionButton.hidden = YES;
        }
    }
}

- (void)hideTimeView {
    
    self.setTimeView.frame = CGRectMake(0, DEFAULT_SCREEN_HEIGHT, self.setTimeView.frame.size.width, self.setTimeView.frame.size.height);
}

- (void)defaultSwitchState {
    
    self.dailySwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kDailySwitchState];
    self.afterNDaysSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kAfterNDaysSwitchState];
}

#pragma mark - Outlets button actions

- (IBAction)dailyReminderButtonAction:(id)sender {
    
    self.pickerType = kUIPickerTypeDaily;
    [self changeFrameAnimation:self.view.frame.size.height - self.setTimeView.frame.size.height];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kDailyReminder])
    {
        [self.setTimeReminderPicker setDate:[[NSUserDefaults standardUserDefaults] valueForKey:kDailyReminder]];
    }
}

- (IBAction)afterNDaysButtonAction:(id)sender {
    
    self.pickerType = kUIPickerTypeAfterNDays;
    [self changeFrameAnimation:self.view.frame.size.height - self.setTimeView.frame.size.height];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kInactivityReminder]) {
        [self.setTimeReminderPicker setDate:[[NSUserDefaults standardUserDefaults] objectForKey:kInactivityReminder] animated:YES];
    }
}

- (IBAction)adterNDaysNumberButtonAction:(id)sender {
    
    self.pickerType = kUIPickerTypeRepetitions;
    self.setTimeReminderPicker.hidden = YES;
    self.setTimeInactiveDayPicker.hidden = NO;
    [self changeFrameAnimation:self.view.frame.size.height - self.setTimeView.frame.size.height];
}

- (IBAction)editNotificationPermissionsButtonAction:(id)sender {
    
    if (!SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (IBAction)setTimeCancelButtonAction:(id)sender {
    
    [self changeFrameAnimation:DEFAULT_SCREEN_HEIGHT];
    if (self.pickerType == kUIPickerTypeRepetitions)
    {
        self.setTimeReminderPicker.hidden = NO;
        self.setTimeInactiveDayPicker.hidden = YES;
    }
}

- (IBAction)setTimeDoneButtonAction:(id)sender {
    
    [self changeFrameAnimation:DEFAULT_SCREEN_HEIGHT];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    switch (self.pickerType) {
            
        case kUIPickerTypeDaily:
            dailyDate = self.setTimeReminderPicker.date;
            [self.dailyHourButton  setTitle:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:self.setTimeReminderPicker.date]] forState:UIControlStateNormal];
            break;
            
        case kUIPickerTypeAfterNDays:
            inactivityDate = self.setTimeReminderPicker.date;
            [self.afterNDaysButton setTitle:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:self.setTimeReminderPicker.date]] forState:UIControlStateNormal];
            break;
            
        case kUIPickerTypeRepetitions:
            self.setTimeReminderPicker.hidden = NO;
            self.setTimeInactiveDayPicker.hidden = YES;
            self.afterNDaysLabel.text = [NSString stringWithFormat:@"After %ld days of inactivity",inactivityLenght];
            [self.afterNDaysInactivityButton setTitle:[NSString stringWithFormat:@"%ld",(long)inactivityLenght] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

#pragma mark - Navigation Bar Button actions

- (IBAction)saveButtonAction:(id)sender {
    
    [self dismissController];
    
    //Daily notification
    if (self.dailySwitch.isOn)
    {
        [[NSUserDefaults standardUserDefaults] setObject:dailyDate forKey:kDailyReminder];
        [self setLocalNotification:dailyDate];
    }
    else
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    //After N days of inactivity notification
    if (self.afterNDaysSwitch.isOn)
    {
        [[NSUserDefaults standardUserDefaults] setObject:inactivityDate forKey:kInactivityReminder];
    }
    //save other values
    [[NSUserDefaults standardUserDefaults] setBool:self.dailySwitch.isOn
                                                        forKey:kDailySwitchState];
    [[NSUserDefaults standardUserDefaults] setBool:self.afterNDaysSwitch.isOn
                                                        forKey:kAfterNDaysSwitchState];
    [[NSUserDefaults standardUserDefaults] setInteger:inactivityLenght forKey:kInactivityLenght];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)cancelButtonAction:(id)sender {
    
    [self dismissController];
}

#pragma mark - Utils

- (void)changeFrameAnimation:(float)yPosition {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.setTimeView.frame = CGRectMake(0, yPosition, self.setTimeView.frame.size.width, self.setTimeView.frame.size.height);
                         if (yPosition == DEFAULT_SCREEN_HEIGHT)
                         {
                             self.coverView.alpha = 0;
                         }
                         else
                         {
                             self.coverView.alpha = 1;
                         }
                     }];
}

- (void)setLocalNotification:(NSDate*)setDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar] ;
    [calendar setLocale:[NSLocale currentLocale]];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *reminderNotification = [[UILocalNotification alloc] init];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:setDate];
    [components setSecond:0];
    NSDate *exactTime = [calendar dateFromComponents:components];
    reminderNotification.fireDate = exactTime;
    reminderNotification.alertBody = @"Don't forget to record your expenses !";
    reminderNotification.soundName = UILocalNotificationDefaultSoundName;
    reminderNotification.repeatInterval = NSCalendarUnitDay;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:reminderNotification];
}

#pragma mark PickerView Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 15;
}

#pragma mark PickerView  Delegate

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView
             attributedTitleForRow:(NSInteger)row
                      forComponent:(NSInteger)component{
    
    return [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d", (int)row+1]
                                           attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    inactivityLenght = row + 1;
}

#pragma mark - Localization

- (void)locaizeUI {
    
    self.dailyReminderLabel.text = @"Daily reminder";
    self.afterNDaysLabel.text = [NSString stringWithFormat:@"After %ld days of inactivity",inactivityLenght];
    self.afterNDaysFrequencyLabel.text = [NSString stringWithFormat:@"%@(%@)",@"Frequency",@"Days"];
    [self.editNotificationPermissionButton setTitle:@"Edit notification permission in IOS settings" forState:UIControlStateNormal];
    [self.setTimeDoneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.setTimeCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
}

-(void)dismissController{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showTabBar:(BOOL)show animationDuration:(float)duration {
    
    CGRect tabBarFrame = tabBarInitialFrame;
    
    if (!show)
    {
        tabBarFrame.origin.y = DEFAULT_SCREEN_HEIGHT;
    }
    
    [UIView animateWithDuration:duration
                     animations:^{
                         
                         self.tabBarController.tabBar.frame = tabBarFrame;
                     }];
}

@end
