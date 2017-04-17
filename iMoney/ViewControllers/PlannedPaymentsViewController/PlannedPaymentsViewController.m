//
//  PlannedPaymentsViewController.m
//  iMoney
//
//  Created by Alex on 4/17/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "PlannedPaymentsViewController.h"

@interface PlannedPaymentsViewController ()

@end

@implementation PlannedPaymentsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpNavigationControllerButtons];
    [self prepareTableView];
}

- (void)prepareTableView {
    
    [self.plannedPaymentsTableView registerNib:[UINib nibWithNibName:@"PlannedPaymentsTableViewCell" bundle:nil] forCellReuseIdentifier:@"PlannedPaymentsTableViewCell"];
    self.plannedPaymentsTableView.tableFooterView = [UIView new];
}

- (void)setUpNavigationControllerButtons {
    
    self.title = @"Planned payments";
    UIBarButtonItem *addWarrientyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                        target:self
                                                                                        action:@selector(addPlannedPaymentButtonAction)];
    
    UIBarButtonItem *sortButton = [iMoneyUtils getNavigationButton:@"ic_sort"
                                                            target:self
                                                       andSelector:@selector(sortButtonAction)];
    
    self.navigationItem.rightBarButtonItems = @[addWarrientyButton, sortButton];
}

#pragma mark - Button actions

- (void)addPlannedPaymentButtonAction {
    
    PlannedPaymentsCreatorViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PlannedPaymentsCreatorViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)sortButtonAction {
    
    
}

#pragma mark - UIActionSheetDelegate


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlannedPaymentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlannedPaymentsTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlannedPaymentsCreatorViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PlannedPaymentsCreatorViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
