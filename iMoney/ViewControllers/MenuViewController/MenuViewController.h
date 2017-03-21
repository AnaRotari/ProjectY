//
//  MenuViewController.h
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewCell.h"

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end
