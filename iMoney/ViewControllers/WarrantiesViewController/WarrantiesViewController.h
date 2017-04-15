//
//  WarrantiesViewController.h
//  iMoney
//
//  Created by Alex on 4/15/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "WarrantiesTableViewCell.h"

@interface WarrantiesViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *listIsEmptyLabel;
@property (weak, nonatomic) IBOutlet UITableView *warrantiesTableView;

@end
