//
//  MainViewController.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MainViewController.h"
#import "ReorderWalletsViewController.h"
#import "DropBoxUtils.h"
#import "TransactionDetailViewController.h"
#import "MainViewController+Navigation.h"

@interface MainViewController () <DropBoxDelegate> {
    
    MenuViewController *sideMenuController;
}

@property (assign, nonatomic) NSInteger selectedWalletIndex;

@end

@implementation MainViewController{
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customSetup];
    [self mainCollectionViewSetup];
    [self mainTableViewSetup];
    [self todayDateSetup];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Dashboard"];
    
    [[DropBoxUtils sharedInstance] setDelegate:self];
    [[DropBoxUtils sharedInstance] logInOrDoStuff:^{
        
        self.collectionDelegates.walletsArray = [CoreDataRequestManager getAllWallets];
        self.collectionDelegates.walletsArray.count ? [self.noWalletsLabel setHidden:YES] : [self.noWalletsLabel setHidden:NO];
        [self.walletsCollectionView reloadData];
        
        if (self.collectionDelegates.walletsArray.count) {
            self.tableDelegates.transactionsArray = [[CoreDataRequestManager getTodayTransactionsForWallet:self.collectionDelegates.walletsArray[self.selectedWalletIndex]] mutableCopy];
        } else {
            [self.tableDelegates.transactionsArray removeAllObjects];
        }
        self.tableDelegates.transactionsArray.count ? [self.noTransactionsLabel setHidden:YES] : [self.noTransactionsLabel setHidden:NO];
        [self.transactionsTableView reloadData];
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    self.selectedWalletIndex = 0;
}

#pragma mark - Initializations

- (void)mainCollectionViewSetup {
    
    [self.walletsCollectionView registerNib:[UINib nibWithNibName:@"MainWalletCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MainWalletCollectionViewCell"];
    self.collectionDelegates = [[MainViewControllerCollectionView alloc] init];
    self.collectionDelegates.delegate = self;
    [self.walletsCollectionView setDataSource: self.collectionDelegates];
    [self.walletsCollectionView setPagerDelegate:self.collectionDelegates];
}

- (void)mainTableViewSetup {
    
    [self.transactionsTableView registerNib:[UINib nibWithNibName:@"TransactionTableViewCell" bundle:nil] forCellReuseIdentifier:@"TransactionTableViewCell"];
    self.tableDelegates = [[MainViewControllerTablleView alloc] init];
    self.tableDelegates.delegate = self;
    [self.transactionsTableView setDataSource:self.tableDelegates];
    [self.transactionsTableView setDelegate:self.tableDelegates];
    self.transactionsTableView.tableFooterView = [UIView new];
}

- (void)todayDateSetup {
    
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, dd MMMM"];
    self.todayDateLabel.text = [dateFormatter stringFromDate:todayDate];
}

#pragma mark - Button action

- (IBAction)addWalletButtonAction:(id)sender {
    
    AddEditWalletViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddEditWalletViewController"];
    controller.walletAction = kAddWallet;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)reorderWalletsButtonAction:(id)sender {
    
    ReorderWalletsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ReorderWalletsViewController"];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - MainViewControllerCollectionViewDelegate

- (void)userDidScrollToWallet:(NSInteger)walletNumber {
    
    self.selectedWalletIndex = walletNumber;
    self.tableDelegates.transactionsArray = [[CoreDataRequestManager getTodayTransactionsForWallet:self.collectionDelegates.walletsArray[self.selectedWalletIndex]] mutableCopy];
    
    self.tableDelegates.transactionsArray.count ? [self.noTransactionsLabel setHidden:YES] : [self.noTransactionsLabel setHidden:NO];

    [self.transactionsTableView reloadData];
}

- (void)userDidSelectWallet:(NSInteger)walletSelected {
    
    SelectedWalletViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectedWalletViewController"];
    controller.selectedWallet = self.collectionDelegates.walletsArray[walletSelected];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - MainViewControllerTablleViewDelegate

- (void)userDidSelectTransaction:(Transaction *)selectedTransaction {
    
    TransactionDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TransactionDetailViewController"];
    controller.transactionDetail = selectedTransaction;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Other stuff

- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController)
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector(revealToggle:)];
        [self.navigationController.navigationBar addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    sideMenuController = (MenuViewController *)revealViewController.rearViewController;
    sideMenuController.delegate = self;
}

#pragma mark - DropBoxDelegate

- (void)downloadCoreDataFinished {
    
    self.collectionDelegates.walletsArray = [CoreDataRequestManager getAllWallets];
    self.collectionDelegates.walletsArray.count ? [self.noWalletsLabel setHidden:YES] : [self.noWalletsLabel setHidden:NO];
    [self.walletsCollectionView reloadData];
    
    if (self.collectionDelegates.walletsArray.count) {
        self.tableDelegates.transactionsArray = [[CoreDataRequestManager getTodayTransactionsForWallet:self.collectionDelegates.walletsArray[self.selectedWalletIndex]] mutableCopy];
    } else {
        [self.tableDelegates.transactionsArray removeAllObjects];
    }
    self.tableDelegates.transactionsArray.count ? [self.noTransactionsLabel setHidden:YES] : [self.noTransactionsLabel setHidden:NO];
    [self.transactionsTableView reloadData];
}

#pragma mark - MenuViewControllerDelegate

- (void)userNavigateTo:(MenuItems)menuItem {
    
    [self.revealViewController revealToggleAnimated:NO];
    
    switch (menuItem) {
        case kMenuItemPlannedPayments:
            NSLog(@"kMenuItemPlannedPayments - not done");
            break;
        case kMenuItemExports:
            NSLog(@"kMenuItemExports - not done");
            break;
        case kMenuItemDebs:
            NSLog(@"kMenuItemDebs - not done");
            break;
        case kMenuItemShoppingLists:
            NSLog(@"Shopping list - maybe done");
            [self goToShoppingList];
            break;
        case kMenuItemWarranties:
            NSLog(@"kMenuItemWarranties - not done");
            break;
        case kMenuItemLocations:
            NSLog(@"kMenuItemLocations - not done");
            break;
        case kMenuItemReminder:
            NSLog(@"kMenuItemReminder - done");
            break;
        case kMenuItemHelp:
            NSLog(@"kMenuItemHelp - not done");
            break;
        case kMenuItemSettings:
            NSLog(@"kMenuItemSettings - not done");
            break;
        case kMenuItemLogout:
            NSLog(@"kMenuItemLogout - done");
            break;
            
        default:
            break;
    }
}

@end
