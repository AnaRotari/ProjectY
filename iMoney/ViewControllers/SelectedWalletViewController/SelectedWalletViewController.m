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
    [self setStatusBarBackgroundColor:[[UIColor alloc] colorWithData:self.wallet.walletColor]];
    [self setupNavigationButton];
    [self disableSwipe];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self setStatusBarBackgroundColor:RGBColor(42, 3, 70, 1)];
}

- (void)initTransactionsTableView {
    
    
}

- (void)setupNavigationButton {
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(showHideButtonsAction)];
    UIBarButtonItem *editButton = [iMoneyUtils getNavigationButton:@"ic_editWallet"
                                                            target:self
                                                       andSelector:@selector(editWalletButtonAction:)];
    
    self.navigationItem.rightBarButtonItems = @[addButton,editButton];
    
    _plusButtonsViewNavBar = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:4
                                                           firstButtonIsPlusButton:NO
                                                                     showAfterInit:NO
                                                                     actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                              {
                                  NSLog(@"actionHandler | title: %@, description: %@, index: %lu", title, description, (long unsigned)index);
                              }];
    [self setupLGNavButton:_plusButtonsViewNavBar andButtonBackgroundColor:[[UIColor alloc] colorWithData:self.wallet.walletColor]];
    [self.view addSubview:_plusButtonsViewNavBar];
}

- (void)viewDidLayoutSubviews {
    
    CGRect newPosition = self.view.frame;
    newPosition.origin.y = newPosition.origin.y + [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    self.view.frame = newPosition;
}

#pragma mark - Button actions

- (void)editWalletButtonAction:(id)sender {
    
#warning NEED TO EDIT WALLET
}

- (void)showHideButtonsAction
{
    if (self.plusButtonsViewNavBar.isShowing) {
        [self.plusButtonsViewNavBar hideAnimated:YES completionHandler:nil];
    }
    else {
        [self.plusButtonsViewNavBar showAnimated:YES completionHandler:nil];
    }
}

@end
