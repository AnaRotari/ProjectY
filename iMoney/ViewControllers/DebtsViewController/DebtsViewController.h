//
//  DebtsViewController.h
//  iMoney
//
//  Created by Alex on 4/21/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "DebtsTableViewCell.h"
#import "DebtsDetailViewController.h"
#import "DebtsTransactionsViewController.h"
#import "MRAlertView.h"

@interface DebtsViewController : BaseViewController <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, DebtsTableViewCellDelegate, MRAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *bedtsLabel;
@property (weak, nonatomic) IBOutlet UITableView *debtsTableView;

@end
