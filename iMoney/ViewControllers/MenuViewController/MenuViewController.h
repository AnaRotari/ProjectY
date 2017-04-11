//
//  MenuViewController.h
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewCell.h"

@protocol MenuViewControllerDelegate <NSObject>

@optional
- (void)userNavigateTo:(MenuItems)menuItem;

@end

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id <MenuViewControllerDelegate> delegate;

@end
