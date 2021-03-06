//
//  NewShoppingListViewController.h
//  iMoney
//
//  Created by Alex on 4/12/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ShoppingListTableViewCell.h"
#import "MRAlertView.h"

@interface ShoppingListViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,MRAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *shoppingListsTableView;
@property (weak, nonatomic) IBOutlet UILabel *noShoppingListsLAbel;

@end
