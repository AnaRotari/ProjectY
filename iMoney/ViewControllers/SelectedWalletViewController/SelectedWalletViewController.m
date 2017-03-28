//
//  SelectedWalletViewController.m
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "SelectedWalletViewController.h"
#import "SelectedWalletViewController+UI.h"

@interface SelectedWalletViewController ()

@property (weak, nonatomic) IBOutlet UITableView *transactionsTableView;

@end

@implementation SelectedWalletViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [iMoneyUtils setStatusBarBackgroundColor:[[UIColor alloc] colorWithData:self.selectedWallet.walletColor]
                     forNavigationController:self.navigationController];
    
    [self setupNavigationBar];
    [self disableSwipe];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [iMoneyUtils setStatusBarBackgroundColor:RGBColor(42, 3, 70, 1)
                     forNavigationController:self.navigationController];
}

- (void)initTransactionsTableView {
    
    
}

- (void)setupNavigationBar {
    
    self.navigationController.title = self.selectedWallet.walletName;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(showHideButtonsAction)];
    UIBarButtonItem *editButton = [iMoneyUtils getNavigationButton:@"ic_editWallet"
                                                            target:self
                                                       andSelector:@selector(editWalletButtonAction:)];
    
    self.navigationItem.rightBarButtonItems = @[addButton,editButton];
    
    _plusButtonsViewNavBar = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:5
                                                           firstButtonIsPlusButton:NO
                                                                     showAfterInit:NO
                                                                     actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                              {
                                  switch (index) {
                                      case 0:
                                          NSLog(@"fucking autolayout");
                                          break;
                                      case 1:
                                          [self addNewRecord];
                                          break;
                                      case 2:
                                          [self transfer];
                                          break;
                                      case 3:
                                          [self chooseTemplate];
                                          break;
                                      case 4:
                                          [self adjustBalance];
                                          break;
                                          
                                      default:
                                          break;
                                  }
                              }];
    [self setupLGNavButton:_plusButtonsViewNavBar andButtonBackgroundColor:[[UIColor alloc] colorWithData:self.selectedWallet.walletColor]];
    [self.view addSubview:_plusButtonsViewNavBar];
}

#pragma mark - Button actions

- (void)editWalletButtonAction:(id)sender {
    
#warning TODO: NEED TO EDIT WALLET
}

#pragma mark - LGPlusButtonsView actions

- (void)addNewRecord {
    
    NSLog(@"addNewRecord");
    TransactionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TransactionViewController"];
    controller.parentWallet = self.selectedWallet;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)transfer {
    
    NSLog(@"transfer");
}

- (void)chooseTemplate {
    
    NSLog(@"chooseTemplate");
}

- (void)adjustBalance {
    
    NSLog(@"adjustBalance");
}

- (void)showHideButtonsAction {
    
    if (self.plusButtonsViewNavBar.isShowing) {
        [self.plusButtonsViewNavBar hideAnimated:YES completionHandler:nil];
    }
    else {
        [self.plusButtonsViewNavBar showAnimated:YES completionHandler:nil];
    }
}

@end
