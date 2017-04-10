//
//  ShoppingListsViewController.m
//  iMoney
//
//  Created by Alex on 4/9/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ShoppingListsViewController.h"
#import "ShoppingListsViewController+UserInterface.h"
#import "ShoppingListTableViewCell.h"

@interface ShoppingListsViewController ()

@end

@implementation ShoppingListsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupLGAPlusButtonActions];
    [self setupTableViewItems];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self setupLGAPlusButton];
    [self.view addSubview:self.plusButtonsViewMain];
}

- (void)setupTableViewItems {
    
    [self.shoppingListItemsTableView registerNib:[UINib nibWithNibName:@"ShoppingListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShoppingListTableViewCell"];
    [self.shoppingListItemsTableView setEditing:YES animated:YES];
}

#pragma mark - LGAPlusButton handlers

- (void)setupLGAPlusButtonActions {
    
    self.plusButtonsViewMain = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:4
                                                         firstButtonIsPlusButton:YES
                                                                   showAfterInit:YES
                                                                   actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                            {
                                switch (index) {
                                    case 1:
                                        [self addItemButtonAction];
                                        break;
                                    case 2:
                                        [self renameShoppingListButtonAction];
                                        break;
                                    case 3:
                                        [self newShoppingListButtonAction];
                                        break;
                                        
                                    default:
                                        break;
                                }
                            }];
}

#pragma mark - Button actions

- (IBAction)closeViewControllerButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)newShoppingListButtonAction {
    
    [self.plusButtonsViewMain hideButtonsAnimated:YES completionHandler:nil];
    
    
    self.createShoppingListAlertView = [[LGAlertView alloc] initWithTextFieldsAndTitle:@"Shopping list"
                                                                     message:@"Enter name"
                                                          numberOfTextFields:1
                                                      textFieldsSetupHandler:^(UITextField *textField, NSUInteger index) {
                                                          
                                                          textField.tag = 1;
                                                          textField.delegate = self;
                                                          textField.enablesReturnKeyAutomatically = YES;
                                                          textField.autocapitalizationType = NO;
                                                          textField.autocorrectionType = NO;
                                                      }
                                                                buttonTitles:@[@"Done"]
                                                           cancelButtonTitle:@"Cancel"
                                                      destructiveButtonTitle:nil
                                                                    delegate:self];
    
    [self.createShoppingListAlertView setButtonEnabled:NO atIndex:0];
    [self.createShoppingListAlertView showAnimated:YES completionHandler:nil];
}

- (void)renameShoppingListButtonAction {
    
    [self.plusButtonsViewMain hideButtonsAnimated:YES completionHandler:nil];
    
}

- (void)addItemButtonAction {
    
    [self.plusButtonsViewMain hideButtonsAnimated:YES completionHandler:nil];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShoppingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingListTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
//    Wallet *currentWallet = self.walletsArray[sourceIndexPath.row];
//    [self.walletsArray removeObjectAtIndex:sourceIndexPath.row];
//    [self.walletsArray insertObject:currentWallet atIndex:destinationIndexPath.row];
//    
//    int i = 1;
//    for (Wallet *wallet in self.walletsArray) {
//        wallet.walletSort = i++;
//    }
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableString *currentString = textField.text.mutableCopy;
    [currentString replaceCharactersInRange:range withString:string];
    [self.createShoppingListAlertView setButtonEnabled:(currentString.length > 2) atIndex:0];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag < 1) {
        [self.createShoppingListAlertView.textFieldsArray[(textField.tag + 1)] becomeFirstResponder];
    }
    else {
        if ([self.createShoppingListAlertView isButtonEnabledAtIndex:0]) {
            [self.createShoppingListAlertView dismissAnimated:YES completionHandler:nil];
        }
        else {
            [textField resignFirstResponder];
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSLog(@"END SHOPING LIST: %@",textField.text);
}

@end
