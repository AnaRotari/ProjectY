//
//  BudgetsViewController.h
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MenuViewController.h"

@interface BudgetsViewController : BaseViewController <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, MenuViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *noBudgetsLabel;
@property (weak, nonatomic) IBOutlet UITableView *budgetsTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealToggleItem;

@end
