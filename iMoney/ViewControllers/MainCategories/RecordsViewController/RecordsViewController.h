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
#import "MenuViewController.h"

@interface RecordsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, RecordsCollectionViewCellDelegate, UIScrollViewDelegate, MenuViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKDropdownMenu *walletsDropDownMenu;
@property (weak, nonatomic) IBOutlet UICollectionView *recordsSwitcherCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *recordsVisualiserTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealToggleItem;

@end
