//
//  AppDelegate.m
//  iMoney
//
//  Created by Admin on 25/02/2017.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseSyncManager.h"
#import "DropBoxUtils.h"
#import "AppDelegate+Notifications.h"
#import "PlannedPaymentsNotificationManager.h"
@import GoogleMaps;
@import GooglePlaces;

static NSString *const kGoogleApiKey = @"AIzaSyBsrWIkSGvj-8ep8pn44POP3ztKTxPAwjA";

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"🗂: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                            inDomains:NSUserDomainMask] lastObject]);
    
    [GMSServices provideAPIKey:kGoogleApiKey];
    [GMSPlacesClient provideAPIKey:kGoogleApiKey];
    
    [[DatabaseSyncManager sharedInstance] startSyncronize];
    [iMoneyUtils setupAppearance];
    [self checkFirstRun];
    
    [PlannedPaymentsNotificationManager createTestInteractiveNotification];
    
//    [self generateFuckingRecords];
    return YES;
}

//Dropbox activity

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return [[DropBoxUtils sharedInstance] setupDropBox:url];
    return true;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(NSString *)source annotation:(id)annotation {
    return [[DropBoxUtils sharedInstance] setupDropBox:url];
    return false;
}

- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
    
    [PlannedPaymentsNotificationManager handleLocalNotification:notification];
    completionHandler();
}


- (void)checkFirstRun {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:kFirstAppRun]) {
        [defaults setBool:YES forKey:kFirstAppRun];
        [defaults synchronize];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *videoFolderPath = [paths firstObject];
        videoFolderPath = [NSString stringWithFormat:@"%@/%@", videoFolderPath, kAppFolder];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:videoFolderPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [self setLocalInactivityNotification];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

- (void)generateFuckingRecords {
    

    NSMutableDictionary *finalTransactionsDetails = @{ kTransactionAmount      : @"312",
                                                       kTransactionAttachemts  : @[],
                                                       kTransactionCategory    : @(2),
                                                       kTransactionDescription : @"TEST",
                                                       kTransactionPayee       : @"TEST",
                                                       kTransactionPaymentType : @(0),
                                                       kTransactionType        : @(1),
                                                       kTransactionLatitude    : @(47.011686),
                                                       kTransactionLongitude   : @(47.011686)}.mutableCopy;

    NSMutableArray *datesArray = [NSMutableArray array];
    NSDate *date = [iMoneyUtils getTodayFormatedDate];
    
    for (int i = 0; i <100; i++) {
        
        date = [[iMoneyUtils getTodayFormatedDate] dateByAddingTimeInterval: -i * 24 * 60 * 60];
        [datesArray addObject:date];
        
    }
    
    Wallet *wallet = [[CoreDataRequestManager getAllWallets] firstObject];
    
    for (int i = 0; i <100; i++) {
        [finalTransactionsDetails setObject:datesArray[i] forKey:kTransactionDate];
        [CoreDataInsertManager createTransaction:finalTransactionsDetails
                                        toWallet:wallet];
    }
}

@end
