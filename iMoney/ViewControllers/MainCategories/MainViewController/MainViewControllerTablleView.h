//
//  MainViewControllerTablleView.h
//  iMoney
//
//  Created by Alex on 3/21/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MainViewControllerTablleViewDelegate <NSObject>

- (void)userDidSelectTransaction:(Transaction *)selectedTransaction;

@end

@interface MainViewControllerTablleView : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <MainViewControllerTablleViewDelegate> delegate;

@property (strong, nonatomic) NSMutableArray <Transaction *> *transactionsArray;

@end
