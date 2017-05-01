//
//  SpiderGraphViewController.h
//  iMoney
//
//  Created by Alex on 5/1/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "MKDropdownMenu.h"

@interface SpiderGraphViewController : BaseViewController <MKDropdownMenuDelegate, MKDropdownMenuDataSource, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *supportView;
@property (weak, nonatomic) IBOutlet MKDropdownMenu *walletsDropDownMenu;

@end
