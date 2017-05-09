//
//  ReorderWalletsViewController.m
//  iMoney
//
//  Created by Alex on 4/6/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ReorderWalletsViewController.h"
#import "WalletTableViewCell.h"

@interface ReorderWalletsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *walletsTableView;
@property (strong, nonatomic) NSMutableArray <Wallet*> *walletsArray;

@end

@implementation ReorderWalletsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.walletsTableView registerNib:[UINib nibWithNibName:@"WalletTableViewCell" bundle:nil] forCellReuseIdentifier:@"WalletTableViewCell"];
    self.walletsArray = [[CoreDataRequestManager getAllWallets] mutableCopy];
    
    [iMoneyUtils setStatusBarBackgroundColor:RGBColor(42, 3, 70, 1)
                     forNavigationController:self.navigationController];
    self.walletsTableView.tableFooterView = [UIView new];
    [self.walletsTableView setEditing:YES animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.walletsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WalletTableViewCell" forIndexPath:indexPath];
    [cell initCellWithWallet:self.walletsArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

    Wallet *currentWallet = self.walletsArray[sourceIndexPath.row];
    [self.walletsArray removeObjectAtIndex:sourceIndexPath.row];
    [self.walletsArray insertObject:currentWallet atIndex:destinationIndexPath.row];

    int i = 1;
    for (Wallet *wallet in self.walletsArray) {
        wallet.walletSort = i++;
    }
}

- (IBAction)cancelButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonAction:(id)sender {
    
    NSManagedObjectContext *context = [[CoreDataAccessLayer sharedInstance] managedObjectContext];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't replace: %@",[error localizedDescription]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
