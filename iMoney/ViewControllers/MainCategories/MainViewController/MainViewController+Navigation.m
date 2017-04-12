//
//  MainViewController+Navigation.m
//  iMoney
//
//  Created by Alex on 4/12/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MainViewController+Navigation.h"
#import "ShoppingListViewController.h"
#import "LocationViewController.h"

@implementation MainViewController (Navigation)

- (void)goToShoppingList {
    
    ShoppingListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingListViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)goToLocationViewController {
    
    LocationViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
