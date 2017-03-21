//
//  MenuViewController.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSArray *menuItemsDictionary;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView {
    
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil]
             forCellReuseIdentifier:@"MenuTableViewCell"];
    self.menuTableView.tableFooterView = [UIView new];
    
    NSArray *contentValues = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuContent" ofType:@"plist"]];
    self.menuItemsDictionary = [[NSArray alloc] initWithArray:contentValues];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.menuItemsDictionary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.menuItemsDictionary[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
    [cell initCellWithValue:self.menuItemsDictionary[indexPath.section][indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"Main";
            break;
        case 1:
            return @"Modules";
            break;
        case 2:
            return @"More";
            break;
        default:
            break;
    }
    return @"Haters gonna hate 😡";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",(long)indexPath.row);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

@end
