//
//  ShoppingListsViewController.h
//  iMoney
//
//  Created by Alex on 4/9/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <LGPlusButtonsView/LGPlusButtonsView.h>
#import <LGAlertView/LGAlertView.h>

@interface ShoppingListsViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, LGAlertViewDelegate>

@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewMain;
@property (weak, nonatomic) IBOutlet UITableView *shoppingListItemsTableView;

@property (strong, nonatomic) LGAlertView *createShoppingListAlertView;
@property (strong, nonatomic) LGAlertView *renameShoppingListAlertView;
@property (strong, nonatomic) LGAlertView *addItemAlertView;

@end
