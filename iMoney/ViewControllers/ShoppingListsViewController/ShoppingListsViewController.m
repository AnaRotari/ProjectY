//
//  ShoppingListsViewController.m
//  iMoney
//
//  Created by Alex on 4/9/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ShoppingListsViewController.h"
#import "ShoppingListsViewController+UserInterface.h"

@interface ShoppingListsViewController ()


@end

@implementation ShoppingListsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupLGAPlusButtonActions];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self setupLGAPlusButton];
    [self.view addSubview:self.plusButtonsViewMain];
}

#pragma mark - LGAPlusButton handlers

- (void)setupLGAPlusButtonActions {
    
    self.plusButtonsViewMain = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:4
                                                         firstButtonIsPlusButton:YES
                                                                   showAfterInit:YES
                                                                   actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                            {
                                NSLog(@"actionHandler | title: %@, description: %@, index: %lu", title, description, (long unsigned)index);
                                
                            }];
}

@end
