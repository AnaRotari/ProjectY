//
//  DebugViewController.m
//  iMoney
//
//  Created by Alex on 3/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "DebugViewController.h"

@interface DebugViewController ()

@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;

@end

@implementation DebugViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (IBAction)magicButtonAction:(id)sender {
    
    [CoreDataRequestManager test1];
}

@end
