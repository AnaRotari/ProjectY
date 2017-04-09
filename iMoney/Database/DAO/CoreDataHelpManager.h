//
//  CoreDataHelpManager.h
//  iMoney
//
//  Created by Alex on 4/9/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelpManager : NSObject

+ (void)transferTransaction:(Transaction *)transaction fromSourceWallet:(Wallet *)sourceWallet toDestinationWallet:(Wallet *)destinationWaller;

@end
