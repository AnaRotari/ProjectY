//
//  PlannedPaymentsCreatorViewController.m
//  iMoney
//
//  Created by Alex on 4/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "PlannedPaymentsCreatorViewController.h"

@interface PlannedPaymentsCreatorViewController ()

@end

@implementation PlannedPaymentsCreatorViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"-----> %@",self.plannedPayment);
    
    PickerViewController *pickerViewController = [[PickerViewController alloc] initFromNib];
    pickerViewController.pickerType = CustomPickerType;
    pickerViewController.dataSourceForCustomPickerType = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    [pickerViewController setInitialItemAtIndex:5];
    pickerViewController.delegate = self;
    [self presentViewControllerOverCurrentContext:pickerViewController animated:YES completion:nil];
}

#pragma mark - PickerViewControllerDelegate

- (void)didSelectDate:(PickerViewController *)picker date:(NSDate *)date formattedString:(NSString *)dateString {
    
    NSLog(@"%@  --  %@",date,dateString);
}

- (void)didSelectItemAtIndex:(PickerViewController *)picker index:(NSUInteger)index {
    
    NSLog(@"%@",picker);
    NSLog(@"%ld",index);
}

@end
