//
//  BudgetsDetailViewController.h
//  iMoney
//
//  Created by Alex on 4/23/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"

@interface BudgetsDetailViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Budget *selectedBudget;

@property (weak, nonatomic) IBOutlet UITableView *budgetTransactionTableView;
@property (weak, nonatomic) IBOutlet UILabel *noTransactionLabel;

@end
