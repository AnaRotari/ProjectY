//
//  ExpensesStructureViewController.h
//  iMoney
//
//  Created by Alex on 5/1/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "MKDropdownMenu.h"
#import "PieChart.h"

@interface ExpensesStructureViewController : BaseViewController <MKDropdownMenuDelegate, MKDropdownMenuDataSource, UIActionSheetDelegate, PieChartDataSource, PieChartDelegate>

@property (weak, nonatomic) IBOutlet MKDropdownMenu *walletsDropDownMenu;

@property (weak, nonatomic) IBOutlet UIView *supportView;
@property (strong, nonatomic) PieChart *expencePieChart;

@end
