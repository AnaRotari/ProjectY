//
//  ChartsViewController.h
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "MenuViewController.h"

@interface ChartsViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate, MenuViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealToggleItem;

@end
