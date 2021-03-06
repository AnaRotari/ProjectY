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
    [sideMenuController setDelegate:self];
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
    
    [self.revealViewController revealToggleAnimated:YES];
    
    switch (menuItem) {
        case kMenuItemPlannedPayments:
            [self goToPlannedPayments];
            break;
        case kMenuItemExports:
            [self goToExportsViewController];
            break;
        case kMenuItemDebs:
            [self goToDebtsViewController];
            break;
        case kMenuItemShoppingLists:
            [self goToShoppingList];
            break;
        case kMenuItemWarranties:
            [self goToWarrantiesViewController];
            break;
        case kMenuItemLocations:
            [self goToLocationViewController];
            break;
        case kMenuItemReminder:
            break;
        case kMenuItemLogout:
            break;
            
        default:
            break;
    }
}

@end
