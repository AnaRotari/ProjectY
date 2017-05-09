//
//  ReportsViewController.h
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "MKDropdownMenu.h"
#import "ReportsCollectionViewCell.h"
#import "MenuViewController.h"

@interface ReportsViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MKDropdownMenuDelegate, MKDropdownMenuDataSource, ReportsCollectionViewCellDelegate, MenuViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *reportsCollectionView;
@property (weak, nonatomic) IBOutlet MKDropdownMenu *walletsDropDownMenu;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealToggleItem;

@end
