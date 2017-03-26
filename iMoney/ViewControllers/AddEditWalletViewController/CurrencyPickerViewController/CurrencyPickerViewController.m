//
//  CurrencyPickerViewController.m
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "CurrencyPickerViewController.h"
#import "CurrencyTableViewCell.h"

@interface CurrencyPickerViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *currencyTableView;
@property (strong, nonatomic) NSArray *currencyDataArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation CurrencyPickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupCurrenctyTableView];
    [self addNavButton];
    [self setStatusBarBackgroundColor:RGBColor(42, 3, 70, 1)];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    self.navigationController.navigationBar.backgroundColor = color;
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)setupCurrenctyTableView {
    
    self.selectedIndex = -1;
    [self.currencyTableView registerNib:[UINib nibWithNibName:@"CurrencyTableViewCell" bundle:nil] forCellReuseIdentifier:@"CurrencyTableViewCell"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"currency" ofType:@"plist"];
    self.currencyDataArray = [NSMutableArray arrayWithContentsOfFile:filePath];
}

- (void)addNavButton {
    
    UIBarButtonItem *doneNavButton = [iMoneyUtils getNavigationButton:@"ic_checkmark"
                                                               target:self
                                                          andSelector:@selector(doneButtonAction:)];
    self.navigationItem.rightBarButtonItems = @[doneNavButton];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.currencyDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CurrencyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CurrencyTableViewCell" forIndexPath:indexPath];
    [cell setupCellWithDict:self.currencyDataArray[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (self.selectedIndex == indexPath.row) {
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndex = indexPath.row;
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndex = -1;
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

#pragma mark - Button actions

- (void)doneButtonAction:(id)sender {
    
    if (self.selectedIndex != -1) {
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(country:didChangeValue:)]) {
            [self.delegate country:self didChangeValue:[self.currencyDataArray objectAtIndex:self.selectedIndex]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        UIAlertController *alert = [UIAlertController
                                     alertControllerWithTitle:@"Oooops !"
                                     message:@"You have not selected any currency. Please select some currency !"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
