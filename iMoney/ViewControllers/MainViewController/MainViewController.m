//
//  MainViewController.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MainViewController.h"
#import "DropBoxUtils.h"

@interface MainViewController () <DropBoxDelegate>

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
    
    [[DropBoxUtils sharedInstance] setDelegate:self];
    [[DropBoxUtils sharedInstance] logInOrDoStuff:^{
        self.collectionDelegates.walletsArray = [CoreDataRequestManager getAllWallets];
        [self.walletsCollectionView reloadData];
        
        if (self.collectionDelegates.walletsArray.count) {
            self.tableDelegates.transactionsArray = [CoreDataRequestManager getTodayTransactionsForWallet:self.collectionDelegates.walletsArray[self.selectedWalletIndex]];
        }
        self.tableDelegates.transactionsArray.count ? [self.noTransactionsLabel setHidden:YES] : [self.noTransactionsLabel setHidden:NO];
        [self.transactionsTableView reloadData];
    }];
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
    [self.transactionsTableView setDataSource:self.tableDelegates];
    [self.transactionsTableView setDelegate:self.tableDelegates];
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

#pragma mark - MainViewControllerCollectionViewDelegate

- (void)userDidScrollToWallet:(NSInteger)walletNumber {
    
    self.selectedWalletIndex = walletNumber;
    self.tableDelegates.transactionsArray = [CoreDataRequestManager getTodayTransactionsForWallet:self.collectionDelegates.walletsArray[self.selectedWalletIndex]];
    
    self.tableDelegates.transactionsArray.count ? [self.noTransactionsLabel setHidden:YES] : [self.noTransactionsLabel setHidden:NO];

    [self.transactionsTableView reloadData];
}

- (void)userDidSelectWallet:(NSInteger)walletSelected {
    
    SelectedWalletViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectedWalletViewController"];
    controller.selectedWallet = self.collectionDelegates.walletsArray[walletSelected];
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
}

#pragma mark - DropBoxDelegate

- (void)downloadCoreDataFinished {
    
    self.collectionDelegates.walletsArray = [CoreDataRequestManager getAllWallets];
    [self.walletsCollectionView reloadData];
    
    if (self.collectionDelegates.walletsArray.count) {
        self.tableDelegates.transactionsArray = [CoreDataRequestManager getTodayTransactionsForWallet:self.collectionDelegates.walletsArray[self.selectedWalletIndex]];
    }
    
    self.tableDelegates.transactionsArray.count ? [self.noTransactionsLabel setHidden:YES] : [self.noTransactionsLabel setHidden:NO];
    [self.transactionsTableView reloadData];
}

@end
