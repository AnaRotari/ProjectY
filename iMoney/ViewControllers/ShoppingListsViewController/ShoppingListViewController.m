//
//  NewShoppingListViewController.m
//  iMoney
//
//  Created by Alex on 4/12/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ShoppingListViewController.h"
#import "ShoppingListContentViewController.h"

@interface ShoppingListViewController ()

@property (strong, nonatomic) NSArray <ShoppingList *> *shoppingListsArray;

@property (strong, nonatomic) LGAlertView *createShoppingListAlertView;

@end

@implementation ShoppingListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self reloadShoppingLists];
}

- (void)setupNavigationBar {
    
    self.title = @"Shopping lists";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addNewShoppingList)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)setupTableView {
    
    [self.shoppingListsTableView registerNib:[UINib nibWithNibName:@"ShoppingListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShoppingListTableViewCell"];
    self.shoppingListsTableView.tableFooterView = [UIView new];
}

- (void)reloadShoppingLists {
    
    self.shoppingListsArray = [CoreDataShoppingListManager getAllShoppingLists];
    self.shoppingListsArray.count ? [self.noShoppingListsLAbel setHidden:YES] : [self.noShoppingListsLAbel setHidden:NO];
    [self.shoppingListsTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Shopping list button actions

- (void)addNewShoppingList {
    
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.shoppingListsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShoppingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingListTableViewCell" forIndexPath:indexPath];
    cell.shoppingListNameLabel.text = self.shoppingListsArray[indexPath.row].listName;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShoppingListContentViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingListContentViewController"];
    controller.selectedShoppingList = self.shoppingListsArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
        NSError *error = nil;
        [context deleteObject:self.shoppingListsArray[indexPath.row]];
        if (![context save:&error]) {
            NSLog(@"Can't delete: %@",[error localizedDescription]);
        }
        [self reloadShoppingLists];
    }
}

#pragma mark - UITextFieldDelegate

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
    
    [CoreDataShoppingListManager createShoppingListWithName:textField.text];
}

#pragma mark - LGAlertViewDelegate

- (void)alertViewWillDismiss:(nonnull LGAlertView *)alertView {
    
    [self reloadShoppingLists];
}

@end
