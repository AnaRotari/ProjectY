//
//  DatabaseSyncManager.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "DatabaseSyncManager.h"
#import "DropBoxUtils.h"

@implementation DatabaseSyncManager

+ (DatabaseSyncManager *)sharedInstance {
    
    __strong static DatabaseSyncManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[DatabaseSyncManager alloc] init];
        NSLog(@"DatabaseSyncManager initialized");
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
    
//    [[DropBoxUtils sharedInstance] uploadCoreData];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSManagedObjectContextDidSaveNotification
                                                  object:nil];
}

@end
