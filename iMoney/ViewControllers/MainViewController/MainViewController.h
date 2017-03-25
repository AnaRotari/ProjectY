//
//  MainViewController.h
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWViewPager.h"
#import "MainViewControllerCollectionView.h"
#import "MainViewControllerTablleView.h"
#import "AddEditWalletViewController.h"

@interface MainViewController : UIViewController

@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property (weak, nonatomic) IBOutlet HWViewPager *walletsCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *transactionsTableView;

@property (strong, nonatomic) MainViewControllerCollectionView *collectionDelegates;
@property (strong, nonatomic) MainViewControllerTablleView *tableDelegates;

@end
