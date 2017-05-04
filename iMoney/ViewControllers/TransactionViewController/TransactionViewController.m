//
//  TransactionViewController.m
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "TransactionViewController.h"
#import "TransactionViewController+DataSource.h"
#import "UserImagesCollectionViewCell.h"
#import <MapKit/MapKit.h>
@import GoogleMaps;
@import GooglePlaces;

@interface TransactionViewController ()<CLLocationManagerDelegate, GMSMapViewDelegate> {
    
    NSInteger selectedTransactionType;
    NSInteger selectedTransactionCateogory;
    NSInteger selectedPaymentType;
    
    __weak IBOutlet GMSMapView *mapViewOutlet;
    CLLocationManager *locationManager;
    
    float zoomLevel;
    double savedLatitude, savedLongitude;
}

@end

@implementation TransactionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    [iMoneyUtils setStatusBarBackgroundColor:[[UIColor alloc] colorWithData:self.parentWallet.walletColor]
                     forNavigationController:self.navigationController];
    [self initData];
    [self setupDropDownMenuApperance];
    [self otherInitializations];
    [self setUpMapView];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self.transactionType closeAllComponentsAnimated:NO];
    [self.transactionCategory closeAllComponentsAnimated:NO];
    [self.paymentType closeAllComponentsAnimated:NO];
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *doneNavButton = [iMoneyUtils getNavigationButton:@"ic_checkmark"
                                                               target:self
                                                          andSelector:@selector(doneButtonAction:)];
    self.navigationItem.rightBarButtonItems = @[doneNavButton];
}

- (void)otherInitializations {
    
    //Trash
    self.amountTextField.placeholder = [NSString stringWithFormat:@"Amount, %@",self.parentWallet.walletCurrency];
    self.dateLabel.text = [iMoneyUtils formatDate:[NSDate date]];
    self.imagesCollectionView.layer.borderWidth = 1.f/[[UIScreen mainScreen] scale];
    self.imagesCollectionView.layer.borderColor = RGBColor(203, 203, 203, 1).CGColor;
    
    //Colletionview
    [self.imagesCollectionView registerNib:[UINib nibWithNibName:@"UserImagesCollectionViewCell" bundle:nil]
                forCellWithReuseIdentifier:@"UserImagesCollectionViewCell"];
    
    self.arrayWithImages = [[NSMutableArray alloc] init];
}

- (void)doneButtonAction:(id)sender {
    
    if ([self checkAllFields]) {
        [self constructTransaction];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"Please fill up all data"];
    }
}

- (BOOL)checkAllFields {
    
    if (self.amountTextField.text.length > 0 && self.descriptionLabel.text.length > 0 && self.payeeLabel.text.length > 0 && self.selectedPaymentTypeLabel.text.length > 0 && self.selectedTransactionCategoryLabel.text.length > 0 && self.selectedTransactionTypeLabel.text.length > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

- (void)constructTransaction {
    
    NSDictionary *finalTransactionsDetails = @{kTransactionAmount      : self.amountTextField.text,
                                               kTransactionAttachemts  : self.arrayWithImages,
                                               kTransactionCategory    : @(selectedTransactionCateogory),
                                               kTransactionDate        : [iMoneyUtils getTodayFormatedDate],
                                               kTransactionDescription : self.descriptionLabel.text,
                                               kTransactionPayee       : self.payeeLabel.text,
                                               kTransactionPaymentType : @(selectedPaymentType),
                                               kTransactionType        : @(selectedTransactionType),
                                               kTransactionLatitude    : @(savedLatitude),
                                               kTransactionLongitude   : @(savedLongitude)};
    
    [CoreDataInsertManager createTransaction:finalTransactionsDetails
                                    toWallet:self.parentWallet];
}

#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    
    if ([dropdownMenu isEqual:self.transactionType]) {
        return self.transactionTypeArray.count;
    }
    if ([dropdownMenu isEqual:self.transactionCategory]) {
        return self.transactionCategoryArray.count;
    }
    if ([dropdownMenu isEqual:self.paymentType]) {
        return self.paymentArray.count;
    }
    return 0;
}

#pragma mark - MKDropdownMenuDelegate

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component {
    
    if ([dropdownMenu isEqual:self.transactionType]) {
        return @"Type";
    }
    if ([dropdownMenu isEqual:self.transactionCategory]) {
        return @"Category";
    }
    if ([dropdownMenu isEqual:self.paymentType]) {
        return @"Payment";
    }
    return @"";
}

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if ([dropdownMenu isEqual:self.transactionType]) {
        return self.transactionTypeArray[row];
    }
    if ([dropdownMenu isEqual:self.transactionCategory]) {
        return self.transactionCategoryArray[row];
    }
    if ([dropdownMenu isEqual:self.paymentType]) {
        return self.paymentArray[row];
    }
    return @"";
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [dropdownMenu closeAllComponentsAnimated:YES];
    if ([dropdownMenu isEqual:self.transactionType]) {
        self.selectedTransactionTypeLabel.text = self.transactionTypeArray[row];
        selectedTransactionType = row;
    }
    if ([dropdownMenu isEqual:self.transactionCategory]) {
        self.selectedTransactionCategoryLabel.text = self.transactionCategoryArray[row];
        selectedTransactionCateogory = row;
    }
    if ([dropdownMenu isEqual:self.paymentType]) {
        self.selectedPaymentTypeLabel.text = self.paymentArray[row];
        selectedPaymentType = row;
    }
}

#pragma mark - Button actions

- (IBAction)addImagesButtonAction:(id)sender {
    
    [self addImagesAlert];
}

- (void)addImagesAlert {
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:@"Options"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    UIAlertAction* addFromGaleryButton = [UIAlertAction
                                          actionWithTitle:@"Choose from library"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * _Nonnull action) {
                                              
                                              UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                              picker.delegate = self;
                                              picker.allowsEditing = YES;
                                              picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                              
                                              [self presentViewController:picker animated:YES completion:nil];
                                          }];
    
    
    UIAlertAction* takePhotoButton = [UIAlertAction
                                      actionWithTitle:@"Take a photo"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * _Nonnull action) {
                                          
                                          UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                          picker.delegate = self;
                                          picker.allowsEditing = YES;
                                          
                                          @try {
                                              
                                              picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                              [self presentViewController:picker animated:YES completion:nil];
                                              
                                          } @catch (NSException *exception) {
                                              
                                              [iMoneyUtils showAlertView:@"Alert" withMessage:@"Don't support camera feature !"];
                                          }
                                          
                                      }];
    
    
    [alert addAction:addFromGaleryButton];
    [alert addAction:takePhotoButton];
    [alert addAction:cancelButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [chosenImage setAccessibilityIdentifier:[iMoneyUtils getUniqID]];
    
    [self writeToDocumentsImage:UIImagePNGRepresentation(chosenImage) withName:chosenImage.accessibilityIdentifier];
    
    [self.arrayWithImages addObject:chosenImage.accessibilityIdentifier];
    [self.imagesCollectionView reloadData];
    
    self.arrayWithImages.count ? [self.noImagesLabel setHidden:YES] : [self.noImagesLabel setHidden:NO];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)writeToDocumentsImage:(NSData *)imageData withName:(NSString *)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *videoFolderPath = [paths firstObject];
    videoFolderPath = [NSString stringWithFormat:@"%@/%@", videoFolderPath, kAppFolder];
    
    NSString *filePath = [videoFolderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
    [imageData writeToFile:filePath atomically:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.arrayWithImages.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UserImagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserImagesCollectionViewCell" forIndexPath:indexPath];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *videoFolderPath = [paths firstObject];
    videoFolderPath = [NSString stringWithFormat:@"%@/%@/%@.png", videoFolderPath, kAppFolder, self.arrayWithImages[indexPath.row]];
    NSData *pngData = [NSData dataWithContentsOfFile:videoFolderPath];
    UIImage *image = [UIImage imageWithData:pngData];
    
    cell.imageCollectionViewOutlet.image = image;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(170,170);
}

- (IBAction)didLongPressCell:(UILongPressGestureRecognizer*)gesture {
    
    CGPoint tapLocation = [gesture locationInView:self.imagesCollectionView];
    NSIndexPath *indexPath = [self.imagesCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath && gesture.state == UIGestureRecognizerStateBegan) {
        
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:nil
                                    message:@"Delete image ?"
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelButton = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        UIAlertAction* deleteImageButton = [UIAlertAction
                                            actionWithTitle:@"Delete"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                [self deleteImageFromCollectionView:(int)indexPath.item];
                                            }];
    
        [alert addAction:deleteImageButton];
        [alert addAction:cancelButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)deleteImageFromCollectionView:(int)index {
    
    [self.arrayWithImages removeObjectAtIndex:index];
    [self.imagesCollectionView reloadData];
    self.arrayWithImages.count ? [self.noImagesLabel setHidden:YES] : [self.noImagesLabel setHidden:NO];
}

#pragma mark - map view methods

-(void)setUpMapView{
    zoomLevel = 15;
    [mapViewOutlet setDelegate:self];
    
    if ([CLLocationManager locationServicesEnabled] ){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 50;
        
        [locationManager requestAlwaysAuthorization];
        [locationManager startUpdatingLocation];
    }else{
        //TODO: show alert to activate location from settings
    }
    
    mapViewOutlet.settings.myLocationButton = true;
    mapViewOutlet.myLocationEnabled = YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    double latitude = location.coordinate.latitude;
    double longitude = location.coordinate.longitude;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:zoomLevel];
    mapViewOutlet.camera = camera;
    
    GMSMarker *marker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(latitude, longitude)];
    [mapViewOutlet clear];
    marker.map = mapViewOutlet;
    
    savedLatitude = latitude;
    savedLongitude = longitude;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    GMSMarker *marker = [GMSMarker markerWithPosition:coordinate];
    [mapViewOutlet clear];
    marker.map = mapViewOutlet;
    
    savedLatitude = coordinate.latitude;
    savedLongitude = coordinate.longitude;
}

@end
