//
//  PlannedPaymentsViewController.h
//  iMoney
//
//  Created by Alex on 4/17/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "PlannedPaymentsTableViewCell.h"
#import "PlannedPaymentsCreatorViewController.h"

@interface PlannedPaymentsViewController : BaseViewController <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *plannedListLabel;
@property (weak, nonatomic) IBOutlet UITableView *plannedPaymentsTableView;

@end
