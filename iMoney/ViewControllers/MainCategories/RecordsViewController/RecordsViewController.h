//
//  RecordsViewController.h
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "MKDropdownMenu.h"
#import "RecordsTableViewCell.h"
#import "RecordsCollectionViewCell.h"
#import "TransactionDetailViewController.h"

@interface RecordsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, RecordsCollectionViewCellDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet MKDropdownMenu *walletsDropDownMenu;
@property (weak, nonatomic) IBOutlet UICollectionView *recordsSwitcherCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *recordsVisualiserTableView;

@end
