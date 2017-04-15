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
#import "WarrantiesViewController.h"

@implementation MainViewController (Navigation)

- (void)goToShoppingList {
    
    ShoppingListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingListViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)goToLocationViewController {

    if ([CoreDataRequestManager getAllTransactions].count > 0) {
        LocationViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"You need create a transaction first !"];
    }
}

- (void)goToWarrantiesViewController {
    
    if ([CoreDataRequestManager getAllWallets].count > 0)
    {
        WarrantiesViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WarrantiesViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"You should create a wallet first !"];
    }
}

@end
