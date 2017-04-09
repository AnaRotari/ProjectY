//
//  TransactionDetailViewController.h
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HistorySegmentedControl.h"
#import <MapKit/MapKit.h>
#import "UserImagesCollectionViewCell.h"

@interface TransactionDetailViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate>

//Data flow
@property (strong, nonatomic) Transaction *transactionDetail;

//Outlets
@property (strong, nonatomic) IBOutlet HistorySegmentedControl *segmentedButtons;
@property (weak, nonatomic) IBOutlet UILabel *transactionAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionDescription;
@property (weak, nonatomic) IBOutlet UILabel *transactionPayee;
@property (weak, nonatomic) IBOutlet UILabel *transactionPaymentsType;
@property (weak, nonatomic) IBOutlet MKMapView *transactionPlace;

@property (weak, nonatomic) IBOutlet UILabel *noImagesLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *attachmentsCollectionView;
@property (strong, nonatomic) NSArray <NSString *> *attachmentsArray;

@end
