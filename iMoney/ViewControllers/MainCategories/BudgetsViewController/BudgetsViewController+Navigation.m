//
//  BudgetsViewController+Navigation.m
//  iMoney
//
//  Created by Alex on 5/9/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BudgetsViewController+Navigation.h"
#import "ShoppingListViewController.h"
#import "LocationViewController.h"
#import "WarrantiesViewController.h"
#import "PlannedPaymentsViewController.h"
#import "ExportsViewController.h"
#import "DebtsViewController.h"

@implementation BudgetsViewController (Navigation)

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

- (void)goToPlannedPayments {
    
    if ([CoreDataRequestManager getAllWallets].count > 0)
    {
        PlannedPaymentsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PlannedPaymentsViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"You should create a wallet first !"];
    }
}

- (void)goToExportsViewController {
    
    if ([CoreDataRequestManager getAllWallets].count > 0)
    {
        ExportsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ExportsViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"You should create a wallet first !"];
    }
}

- (void)goToDebtsViewController {
    
    if ([CoreDataRequestManager getAllWallets].count > 0)
    {
        DebtsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DebtsViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"You should create a wallet first !"];
    }
}

@end
