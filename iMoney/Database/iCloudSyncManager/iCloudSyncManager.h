//
//  iCloudSyncManager.h
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iCloudSyncManager : NSObject

@property (strong, nonatomic) NSUbiquitousKeyValueStore *iCloudStore;

+ (iCloudSyncManager *)sharedInstance;
- (void)startSyncronize;

@end
