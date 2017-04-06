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

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"🗂: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                            inDomains:NSUserDomainMask] lastObject]);
    [[DatabaseSyncManager sharedInstance] startSyncronize];
    [iMoneyUtils setupAppearance];
    [self checkFirstRun];
    
//    [[[CoreDataAccessLayer sharedInstance] managedObjectContext] performBlockAndWait:^{
//       [[CoreDataAccessLayer sharedInstance] resetDatabase];
//    }];
    
    return YES;
}

//iOS 9 workflow
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return [[DropBoxUtils sharedInstance] setupDropBox:url];
    return true;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(NSString *)source annotation:(id)annotation {
    return [[DropBoxUtils sharedInstance] setupDropBox:url];
    return false;
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

@end
