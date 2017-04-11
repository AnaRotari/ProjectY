//
//  ListItemTableViewCell.h
//  iMoney
//
//  Created by Alex on 4/12/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

@interface ListItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet BEMCheckBox *itemCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *itemName;

@end
