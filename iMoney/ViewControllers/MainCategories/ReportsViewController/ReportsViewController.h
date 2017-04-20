//
//  ReportsViewController.h
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "BaseViewController.h"
#import "MKDropdownMenu.h"

@interface ReportsViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MKDropdownMenuDelegate, MKDropdownMenuDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *reportsCollectionView;
@property (weak, nonatomic) IBOutlet MKDropdownMenu *walletsDropDownMenu;

@end
