//
//  MainViewControllerTablleView.h
//  iMoney
//
//  Created by Alex on 3/21/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainViewControllerTablleView : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray <Transaction *> *transactionsArray;

@end
