//
//  MenuViewController.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "MenuViewController.h"
#import "DropBoxUtils.h"
#import "ReminderViewController.h"

@interface MenuViewController () <DropBoxDelegate>

@property (strong, nonatomic) NSArray *menuItemsArray;
@property (strong, nonatomic) NSArray *menuImagesArray;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[DropBoxUtils sharedInstance] setDelegate:self];
    [_userNameLabel setText:[[NSUserDefaults standardUserDefaults] objectForKey:kUserName]];
}

- (void)setupTableView {
    
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil]
             forCellReuseIdentifier:@"MenuTableViewCell"];
    self.menuTableView.tableFooterView = [UIView new];
    
    NSArray *contentValues = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuContent" ofType:@"plist"]];
    self.menuItemsArray = [[NSArray alloc] initWithArray:contentValues];
    
    NSArray *imagesValues = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuImages" ofType:@"plist"]];
    self.menuImagesArray = [[NSArray alloc] initWithArray:imagesValues];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.menuItemsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.menuItemsArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
    [cell initCellWithValue:self.menuItemsArray[indexPath.section][indexPath.row]
               andImageName:self.menuImagesArray[indexPath.section][indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"Modules";
            break;
        case 1:
            return @"Other";
            break;
        default:
            break;
    }
    return @"Haters gonna hate 😡";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(userNavigateTo:)]) {
            [self.delegate userNavigateTo:kMenuItemPlannedPayments];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(userNavigateTo:)]) {
            [self.delegate userNavigateTo:kMenuItemExports];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(userNavigateTo:)]) {
            [self.delegate userNavigateTo:kMenuItemDebs];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(userNavigateTo:)]) {
            [self.delegate userNavigateTo:kMenuItemShoppingLists];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(userNavigateTo:)]) {
            [self.delegate userNavigateTo:kMenuItemWarranties];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(userNavigateTo:)]) {
            [self.delegate userNavigateTo:kMenuItemLocations];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 6) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(userNavigateTo:)]) {
            [self.delegate userNavigateTo:kMenuItemReminder];
        }
        [self openReminderViewController];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(userNavigateTo:)]) {
            [self logoutUser];
        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

-(void)DropBoxStateChangedWithText:(NSString *)text{
    [_userNameLabel setText:text];
}

#pragma mark - Side menu actions

- (void)openReminderViewController {
    
    ReminderViewController *reminderViewController = [[ReminderViewController alloc] init];
    [self presentViewController:reminderViewController animated:YES completion:nil];
}

- (void)logoutUser {
    
    [self.revealViewController revealToggleAnimated:YES];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray<NSString *> *fileNames = @[kDBiMoneySQLite, kDBiMoneySQLiteSHM, kDBiMoneySQLiteWAL];
    
    for (NSString *fileName in fileNames) {
        
        NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
        NSError *error;
        BOOL success = [fileManager removeItemAtPath:filePath error:&error];
        if (!success) {
            NSLog(@"Cant delete: %@ because: %@",fileName,[error localizedDescription]);
        }
        else {
            NSLog(@"Success");
        }
    }

    [[DropBoxUtils sharedInstance] logOut];
    [[DropBoxUtils sharedInstance] logIn];
}

@end
