//
//  iCloudSyncManager.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "iCloudSyncManager.h"

@implementation iCloudSyncManager

+ (iCloudSyncManager *)sharedInstance {
    
    __strong static iCloudSyncManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[iCloudSyncManager alloc] init];
        sharedInstance.iCloudStore = [NSUbiquitousKeyValueStore defaultStore];
        NSLog(@"iCloud manager initialized");
    });
    
    return sharedInstance;
}

- (void)startSyncronize {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(coreDataChangeObserver:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
}

- (void)coreDataChangeObserver:(NSNotification *)notification {
    
    if (self.iCloudStore != nil)
    {
#warning TODO: Add serialization and upload to iCloud
        NSLog(@"Add serialization and upload to iCloud");
//        [self.iCloudStore synchronize];
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSManagedObjectContextDidSaveNotification
                                                  object:nil];
}

@end
