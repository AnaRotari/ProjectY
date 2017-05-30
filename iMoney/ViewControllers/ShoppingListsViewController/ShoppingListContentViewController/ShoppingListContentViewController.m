//
//  ShoppingListContentViewController.m
//  iMoney
//
//  Created by Alex on 4/12/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ShoppingListContentViewController.h"

@interface ShoppingListContentViewController () {
    
    Wallet *walletToInsert;
    NSString *insertAmount;
}

@property (strong,nonatomic) NSMutableArray <ListItem *> *listItemsArray;
@property (strong,nonatomic) NSArray <Wallet *> *walletsArray;

@property (strong, nonatomic) LGAlertView *createItemListAlertView;
@property (strong, nonatomic) LGAlertView *insertMoneyAlertView;

@end

@implementation ShoppingListContentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.shoppingListNameTextField.text = self.selectedShoppingList.listName;
    [self setupNavigationBar];
    [self setupItemsTableView];
    self.walletsArray = [CoreDataRequestManager getAllWallets];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[CoreDataAccessLayer sharedInstance] saveContext];
}

- (void)setupNavigationBar {
    
    self.title = self.selectedShoppingList.listName;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addNewItemInList)];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(editButtonAction)];
    
    UIBarButtonItem *addToWalletAmount = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                                       target:self
                                                                                       action:@selector(addToWalletAmountButtonAction)];
    
    self.navigationItem.rightBarButtonItems = @[addButton,editButton,addToWalletAmount];
}

- (void)setupItemsTableView {
    
    [self.listItemsTableView registerNib:[UINib nibWithNibName:@"ListItemTableViewCell" bundle:nil] forCellReuseIdentifier:@"ListItemTableViewCell"];
    self.listItemsTableView.tableFooterView = [UIView new];
    [self reloadItems];
}

- (void)reloadItems {
    
    self.listItemsArray = [[CoreDataShoppingListManager getAllItemsForShoppingList:self.selectedShoppingList] mutableCopy];
    self.listItemsArray.count ? [self.noItemsInListLabel setHidden:YES] : [self.noItemsInListLabel setHidden:NO];
    [self.listItemsTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)addNewItemInList {
    
    self.createItemListAlertView = [[LGAlertView alloc] initWithTextFieldsAndTitle:@"Shopping list item"
                                                                               message:@"Enter item name"
                                                                    numberOfTextFields:1
                                                                textFieldsSetupHandler:^(UITextField *textField, NSUInteger index) {
                                                                    
                                                                    textField.tag = 20;
                                                                    textField.delegate = self;
                                                                    textField.enablesReturnKeyAutomatically = YES;
                                                                    textField.autocapitalizationType = NO;
                                                                    textField.autocorrectionType = NO;
                                                                }
                                                                          buttonTitles:@[@"Done"]
                                                                     cancelButtonTitle:@"Cancel"
                                                                destructiveButtonTitle:nil
                                                                              delegate:self];
    
    __weak typeof(self) wself = self;
    self.createItemListAlertView.actionHandler = ^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
        __strong typeof(wself) sself = wself;
        
        for (UITextField *textField in alertView.textFieldsArray) {
            
            if (textField.tag == 20 && textField.text.length > 0) {
                [CoreDataShoppingListManager createItemInShoppingList:sself.selectedShoppingList withName:textField.text];
                [sself reloadItems];
            }
        }
    };
    
    [self.createItemListAlertView setButtonEnabled:NO atIndex:0];
    [self.createItemListAlertView showAnimated:YES completionHandler:nil];
}

- (void)editButtonAction {
    
    self.listItemsTableView.isEditing ? [self.listItemsTableView setEditing:NO animated:YES] : [self.listItemsTableView setEditing:YES animated:YES];
}

- (void)addToWalletAmountButtonAction {
    
    self.insertMoneyAlertView = [[LGAlertView alloc] initWithTextFieldsAndTitle:@"Insert in Wallet"
                                                                               message:@"Enter amount"
                                                                    numberOfTextFields:1
                                                                textFieldsSetupHandler:^(UITextField *textField, NSUInteger index) {
                                                                    
                                                                    textField.tag = 30;
                                                                    textField.delegate = self;
                                                                    textField.enablesReturnKeyAutomatically = YES;
                                                                    textField.autocapitalizationType = NO;
                                                                    textField.autocorrectionType = NO;
                                                                    textField.keyboardType = UIKeyboardTypeNumberPad;
                                                                }
                                                                          buttonTitles:@[@"Done"]
                                                                     cancelButtonTitle:@"Cancel"
                                                                destructiveButtonTitle:nil
                                                                              delegate:self];
    __weak typeof(self) wself = self;
    self.insertMoneyAlertView.actionHandler = ^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
        __strong typeof(wself) sself = wself;
        [sself showWalletActionSheet:sself.walletsArray];
    };
    
    [self.insertMoneyAlertView setButtonEnabled:NO atIndex:0];
    [self.insertMoneyAlertView showAnimated:YES completionHandler:nil];
}

- (void)showWalletActionSheet:(NSArray <Wallet *> *)wallets {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"Available wallets";
    actionSheet.delegate = self;
    
    for (Wallet *extractedWallet in wallets) {
        
        [actionSheet addButtonWithTitle:extractedWallet.walletName];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView: self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
     
        NSDictionary *newTransaction = @{kTransactionAmount      : insertAmount,
                                         kTransactionAttachemts  : @[],
                                         kTransactionCategory    : @(1),
                                         kTransactionDate        : [iMoneyUtils getTodayFormatedDate],
                                         kTransactionDescription : @"",
                                         kTransactionPayee       : @"",
                                         kTransactionPaymentType : @(0),
                                         kTransactionType        : @(1)};;
        
        [CoreDataInsertManager createTransaction:newTransaction toWallet:self.walletsArray[buttonIndex]];
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 10 && textField.text.length > 0)
    {
        self.selectedShoppingList.listName = textField.text;
        [[CoreDataAccessLayer sharedInstance] saveContext];
    }
    if (textField.tag == 30 && textField.text.length > 0)
    {
        insertAmount = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 10)
    {
        [textField resignFirstResponder];
    }
    if (textField.tag == 20)
    {
        if ([self.createItemListAlertView isButtonEnabledAtIndex:0])
        {
            [self.createItemListAlertView dismissAnimated:YES completionHandler:nil];
        }
        else
        {
            [textField resignFirstResponder];
        }
    }
    if (textField.tag == 30)
    {
        if ([self.insertMoneyAlertView isButtonEnabledAtIndex:0])
        {
            [self.insertMoneyAlertView dismissAnimated:YES completionHandler:nil];
        }
        else
        {
            [textField resignFirstResponder];
        }
    }

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 10)
    {
        
    }
    if (textField.tag == 20)
    {
        NSMutableString *currentString = textField.text.mutableCopy;
        [currentString replaceCharactersInRange:range withString:string];
        [self.createItemListAlertView setButtonEnabled:(currentString.length > 1) atIndex:0];
    }
    if (textField.tag == 30)
    {
        NSMutableString *currentString = textField.text.mutableCopy;
        [currentString replaceCharactersInRange:range withString:string];
        [self.insertMoneyAlertView setButtonEnabled:(currentString.length > 1) atIndex:0];
    }
    
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listItemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListItemTableViewCell" forIndexPath:indexPath];
    cell.itemName.text = self.listItemsArray[indexPath.row].itemName;
    [cell setCompletedItem:self.listItemsArray[indexPath.row].itemIsDone];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.listItemsArray[indexPath.row].itemIsDone) {
        self.listItemsArray[indexPath.row].itemIsDone = NO;
    } else {
        self.listItemsArray[indexPath.row].itemIsDone = YES;
    }
    
    [[CoreDataAccessLayer sharedInstance] saveContext];
    
    [self.listItemsTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    ListItem *listItem = self.listItemsArray[sourceIndexPath.row];
    
    [self.listItemsArray removeObjectAtIndex:sourceIndexPath.row];
    [self.listItemsArray insertObject:listItem atIndex:destinationIndexPath.row];
    
    int i = 1;
    for (ListItem *item in self.listItemsArray) {
        item.itemSort = i++;
    }
    
    [[CoreDataAccessLayer sharedInstance] saveContext];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
        NSError *error = nil;
        [context deleteObject:self.listItemsArray[indexPath.row]];
        if (![context save:&error]) {
            NSLog(@"Can't delete: %@",[error localizedDescription]);
        }
        [self reloadItems];
    }
}

@end
