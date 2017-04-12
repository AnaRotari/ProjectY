//
//  ShoppingListContentViewController.h
//  iMoney
//
//  Created by Alex on 4/12/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItemTableViewCell.h"

@interface ShoppingListContentViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate,LGAlertViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) ShoppingList *selectedShoppingList;

@property (weak, nonatomic) IBOutlet UITextField *shoppingListNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *listItemsTableView;
@property (weak, nonatomic) IBOutlet UILabel *noItemsInListLabel;

@end
