//
//  TransactionDetailViewController.h
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HistorySegmentedControl.h"

@interface TransactionDetailViewController : BaseViewController

//Data flow
@property (strong, nonatomic) Transaction *transactionDetail;

//Outlets
@property (strong, nonatomic) IBOutlet HistorySegmentedControl *segmentedButtons;

@end
