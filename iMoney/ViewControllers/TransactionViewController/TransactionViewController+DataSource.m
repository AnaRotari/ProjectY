//
//  TransactionViewController+DataSource.m
//  iMoney
//
//  Created by Alex on 4/3/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "TransactionViewController+DataSource.h"

@implementation TransactionViewController (DataSource)

- (void)setupDropDownMenuApperance {
    
    NSArray <MKDropdownMenu *> *arrayWithDropDown = @[self.transactionCategory, self.transactionType, self.paymentType];
    for (MKDropdownMenu *menu in arrayWithDropDown) {
        menu.componentTextAlignment = NSTextAlignmentLeft;
        menu.layer.borderWidth = 1.f/[UIScreen mainScreen].scale;;
        menu.layer.borderColor = RGBColor(205, 205, 205, 1).CGColor;
        menu.backgroundDimmingOpacity = 0;
    }
}

- (void)initData {
    
    self.transactionTypeArray = @[@"Income",
                                  @"Expense"];
    
    self.transactionCategoryArray = @[@"Food And Drinks",
                                      @"Shopping",
                                      @"Housing",
                                      @"Transportation",
                                      @"Vechicle",
                                      @"Life And Entertainments",
                                      @"PC",
                                      @"Financial Expenses",
                                      @"Investments",
                                      @"Income",
                                      @"Gregories",
                                      @"Other"];
    
    self.paymentArray = @[@"Cash",
                          @"Debit Card",
                          @"Credit Card",
                          @"Transfer",
                          @"Voucher",
                          @"Mobile Payment",
                          @"Web Payment"];
}

@end
