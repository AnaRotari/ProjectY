//
//  DebtsViewController.h
//  iMoney
//
//  Created by Alex on 4/21/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"

@interface DebtsViewController : BaseViewController <UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *bedtsLabel;
@property (weak, nonatomic) IBOutlet UITableView *debtsTableView;

@end
