//
//  LocationViewController.m
//  iMoney
//
//  Created by Alex on 4/12/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "LocationViewController.h"
@import GoogleMaps;
@import GooglePlaces;

@interface LocationViewController()<UIActionSheetDelegate>

@end

@interface LocationViewController (){
    GMSMapView *mapView;
    SortType sortType;
    TransactionType selectedTransactionType;
    SortOptions _sortOption;
}

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSortButtons];
    [self reloadDataForSortOption:kSortOptionShowAll];
}

#pragma mark - reload data

-(void)reloadDataForSortOption:(SortOptions)sortOption{
    _sortOption = sortOption;
    NSArray<Transaction*> *transactions = [CoreDataRequestManager getAllTransactionsForSortOption:sortOption];
    [self setUpMapViewForTransactions:transactions];
}

-(void)sortByTransactionType:(TransactionType)type{
    NSArray<Transaction*> *transactions = [CoreDataRequestManager getAllTransactionsForSortOption:_sortOption];
    NSMutableArray<Transaction*> *tmpTransactions = [NSMutableArray array];
    
    for (Transaction *transaction in transactions) {
        if (transaction.transactionType == type) {
            [tmpTransactions addObject:transaction];
        }
    }
    
    [self setUpMapViewForTransactions:tmpTransactions];
}

#pragma mark - sort methods

-(void)setUpSortButtons{
    UIBarButtonItem *sortButtonByDate = [iMoneyUtils getNavigationButton:@"ic_sort"
                                                            target:self
                                                       andSelector:@selector(sortButtonActionByDate:)];
    
    UIBarButtonItem *sortButtonByTransactionType = [iMoneyUtils getNavigationButton:@"ic_sort"
                                                            target:self
                                                       andSelector:@selector(sortButtonActionTransactionType:)];
    
    self.navigationItem.rightBarButtonItems = @[sortButtonByDate, sortButtonByTransactionType];
}

- (void)sortButtonActionByDate:(UIBarButtonItem *)sender {
    sortType = DateSort;
    [self showSortActionSheet:@[@"Show all",@"Show today",@"Show last week",@"Show last month",@"Show last year"]];
}

- (void)sortButtonActionTransactionType:(UIBarButtonItem *)sender {
    sortType = TransactionTypeSort;
    [self showSortActionSheet:@[@"Income",@"Expense"]];
}

#pragma mark - UIActionSheetDelegate

- (void)showSortActionSheet:(NSArray <NSString *> *)sortOptionsArray {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"Sorting options";
    actionSheet.delegate = self;
    
    for (NSString *option in sortOptionsArray) {
        
        [actionSheet addButtonWithTitle:option];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView: self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        switch (sortType) {
            case DateSort:
                [self reloadDataForSortOption:buttonIndex];
                break;
            case TransactionTypeSort:
                [self sortByTransactionType:buttonIndex];
                break;
            default:
                break;
        }
    }
}

-(void)setUpMapViewForTransactions:(NSArray<Transaction*> *)transactions{
    if (transactions.count == 0) {
        if (mapView) {
            [mapView clear];
        }
        return;
    }
    
    double latitude = transactions[0].transactionLatitude;
    double longitude = transactions[0].transactionLongitude;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:12];
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    [mapView clear];
    
    mapView.settings.myLocationButton = true;
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    for (Transaction *transaction in transactions) {
        double latitude = transaction.transactionLatitude;
        double longitude = transaction.transactionLongitude;
        
        GMSMarker *marker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(latitude, longitude)];
        marker.map = mapView;
    }
}

@end
