//
//  DatabaseSyncManager.h
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseSyncManager : NSObject

+ (DatabaseSyncManager *)sharedInstance;
- (void)startSyncronize;

@end
