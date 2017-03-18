//
//  MenuViewController.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

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
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",(long)indexPath.row);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

@end
