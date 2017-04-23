//
//  BudgetsViewController.h
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BudgetsViewController : BaseViewController <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *noBudgetsLabel;
@property (weak, nonatomic) IBOutlet UITableView *budgetsTableView;

@end
