//
//  MainViewController.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customSetup];
    [self mainCollectionViewSetup];
    [self mainTableViewSetup];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.collectionDelegates.walletsArray = [CoreDataRequestManager getAllWallets];
    [self.walletsCollectionView reloadData];
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

#pragma mark - Button action

- (IBAction)addWalletButtonAction:(id)sender {
    
    AddEditWalletViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddEditWalletViewController"];
    controller.walletAction = kAddWallet;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - MainViewControllerCollectionViewDelegate

- (void)userDidScrollToWallet:(NSInteger)walletNumber {
    
    //Need to update UI
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

@end
