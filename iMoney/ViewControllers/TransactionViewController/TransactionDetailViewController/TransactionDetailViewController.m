//
//  TransactionDetailViewController.m
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "TransactionDetailViewController.h"

@interface TransactionDetailViewController ()

@end

@implementation TransactionDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Transaction details";
    [self segmentControllSetup];
    NSArray *test = [[NSArray alloc] arrayWithData:self.transactionDetail.transactionAttachments];
    NSLog(@"%@",test);
}

#pragma mark - Segmented Controll

- (void)segmentControllSetup {
    
    [self.segmentedButtons setSegmentsColor];
    [self.segmentedButtons setFonts];
    [self.segmentedButtons setSelectedSegmentIndex:1];
}

- (IBAction)segmentControlAction:(HistorySegmentedControl *)sender {
    
    int tag = (int)[sender selectedSegmentIndex];
    
}

@end
