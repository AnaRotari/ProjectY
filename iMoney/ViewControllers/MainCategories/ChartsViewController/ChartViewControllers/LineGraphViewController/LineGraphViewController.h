//
//  LineGraphViewController.h
//  iMoney
//
//  Created by Alex on 4/30/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "BEMSimpleLineGraphView.h"
#import "MKDropdownMenu.h"

@interface LineGraphViewController : BaseViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate, MKDropdownMenuDelegate, MKDropdownMenuDataSource, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *graphView;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;
@property (weak, nonatomic) IBOutlet MKDropdownMenu *walletsDropDownMenu;

@end
