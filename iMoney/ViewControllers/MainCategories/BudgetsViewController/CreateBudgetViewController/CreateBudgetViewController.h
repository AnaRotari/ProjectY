//
//  CreateBudgetViewController.h
//  iMoney
//
//  Created by Alex on 4/23/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "BudgetWalletTableViewCell.h"

@interface CreateBudgetViewController : BaseViewController <UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *budgetNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *budgetAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *selectedPeriodLabel;
@property (weak, nonatomic) IBOutlet UITableView *walletsTableView;

@end
