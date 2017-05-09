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
    
    MRAlertView *alertView = [[MRAlertView alloc] initWithTitle:@"Shopping list"
                                                        message:@"Enter name"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK"];
    [alertView setAlertViewStyle:MRAlertViewStylePlainTextInput];
    [alertView show];
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

#pragma mark - MRAlertViewDelegate

- (void)alertView:(MRAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1)
    {
        if ([alertView.textView.text length] > 0)
        {
            [CoreDataShoppingListManager createShoppingListWithName:alertView.textView.text];
            [self reloadShoppingLists];
        }
    }
}

@end
