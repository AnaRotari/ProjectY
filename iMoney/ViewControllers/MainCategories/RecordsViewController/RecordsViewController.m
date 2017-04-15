//
//  RecordsViewController.m
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "RecordsViewController.h"
#import "MKDropdownMenu.h"

@interface RecordsViewController () <MKDropdownMenuDelegate,MKDropdownMenuDataSource>

@property (weak, nonatomic) IBOutlet MKDropdownMenu *walletsDropDownMenu;

@end

@implementation RecordsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    
    return 2;
}

#pragma mark - MKDropdownMenuDelegate

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component {
    
    return @"Wallet Wallet";
}

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return @"1111";
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [dropdownMenu closeAllComponentsAnimated:YES];
//    self.selectedTransactionTypeLabel.text = self.transactionTypeArray[row];
//    selectedTransactionType = row;
}

#pragma mark - Button actions

- (IBAction)sortButtonActionByDate:(UIBarButtonItem *)sender {
    
    [self showSortActionSheet:@[@"Show all",@"Show today",@"Show last week",@"Show last month",@"Show last year"]];
}

#pragma mark - UIActionSheetDelegate

- (void)showSortActionSheet:(NSArray <NSString *> *)sortOptionsArray {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"Sorting options";
    actionSheet.delegate = self;
    
    for (NSString *option in sortOptionsArray) {
        
        [actionSheet addButtonWithTitle:option];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView: self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != actionSheet.cancelButtonIndex){
        
    }
}

@end
