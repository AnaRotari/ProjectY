//
//  DebtsTransactionsViewController.h
//  iMoney
//
//  Created by Alex on 4/24/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"

@interface DebtsTransactionsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray <Transaction *> *transactionsArray;

@property (weak, nonatomic) IBOutlet UITableView *debtTransactionsTableView;

@end
