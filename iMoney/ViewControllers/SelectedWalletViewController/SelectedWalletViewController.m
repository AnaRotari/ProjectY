//
//  SelectedWalletViewController.m
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "SelectedWalletViewController.h"
#import "SelectedWalletViewController+UI.h"
#import "TransactionTableViewCell.h"
#import "AddEditWalletViewController.h"
#import "TransactionDetailViewController.h"

@interface SelectedWalletViewController ()

@property (weak, nonatomic) IBOutlet UITableView *transactionsTableView;
@property (strong, nonatomic) NSMutableArray <Transaction *> *transactionsArray;

@end

@implementation SelectedWalletViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [iMoneyUtils setStatusBarBackgroundColor:[[UIColor alloc] colorWithData:self.selectedWallet.walletColor]
                     forNavigationController:self.navigationController];
    
    [self setupNavigationBar];
    [self disableSwipe];
    [self setupTransactionTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.transactionsArray = [[CoreDataRequestManager getAllTransactionForWallet:self.selectedWallet] mutableCopy];
    [self.transactionsTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                              withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [iMoneyUtils setStatusBarBackgroundColor:RGBColor(42, 3, 70, 1)
                     forNavigationController:self.navigationController];
}

- (void)setupTransactionTableView {
    
    [self.transactionsTableView registerNib:[UINib nibWithNibName:@"TransactionTableViewCell" bundle:nil] forCellReuseIdentifier:@"TransactionTableViewCell"];
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
                                  [self showHideButtonsAction];
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
    
    AddEditWalletViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddEditWalletViewController"];
    controller.walletAction = kEditWallt;
    controller.walletToEdit = self.selectedWallet;
    [self.navigationController pushViewController:controller animated:YES];
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
    NSArray *totalWallets = [CoreDataRequestManager getAllWallets];
    if (totalWallets.count > 1) {
        NSLog(@"you can transfer");
    } else {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"You cant transfer amount if you have less than 1 wallet !"];
    }
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.transactionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionTableViewCell" forIndexPath:indexPath];
    [cell initTransactionCell:self.transactionsArray[indexPath.row] hidesDateLabel:NO];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TransactionDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TransactionDetailViewController"];
    controller.transactionDetail = self.transactionsArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Transaction *deletedTransaction = self.transactionsArray[indexPath.row];
    
        switch (deletedTransaction.transactionType) {
            
            case kTransactionTypeIncome:
                self.selectedWallet.walletBalance = [self.selectedWallet.walletBalance decimalNumberBySubtracting:deletedTransaction.transactionAmount];
                break;
            case kTransactionTypeExpense:
                self.selectedWallet.walletBalance = [self.selectedWallet.walletBalance decimalNumberByAdding:deletedTransaction.transactionAmount];
                break;
                
            default:
                break;
        }
        
        NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
        NSError *error = nil;
        
        [context deleteObject:deletedTransaction];
        
        if (![context save:&error]) {
            NSLog(@"Can't delete: %@",[error localizedDescription]);
        }
        
        [self.transactionsArray removeObjectAtIndex:indexPath.row];
        
        [self.transactionsTableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                  withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
