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

@interface TransactionViewController ()

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
    
    [self constructTransaction];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

- (void)constructTransaction {
   
    NSDictionary *finalTransactionsDetails = @{kTransactionAmount      : self.amountTextField.text,
                                               kTransactionAttachemts  : self.arrayWithImages,
                                               kTransactionCategory    : self.selectedTransactionCategoryLabel.text,
                                               kTransactionDate        : [iMoneyUtils getTodayFormatedDate],
                                               kTransactionDescription : self.descriptionLabel.text,
                                               kTransactionPayee       : self.payeeLabel.text,
                                               kTransactionPaymentType : self.selectedPaymentTypeLabel.text,
                                               kTransactionType        : self.selectedTransactionTypeLabel.text};
    
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
    }
    if ([dropdownMenu isEqual:self.transactionCategory]) {
        self.selectedTransactionCategoryLabel.text = self.transactionCategoryArray[row];
    }
    if ([dropdownMenu isEqual:self.paymentType]) {
        self.selectedPaymentTypeLabel.text = self.paymentArray[row];
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
    [self.arrayWithImages addObject:chosenImage];
    [self.imagesCollectionView reloadData];
    
    self.arrayWithImages.count ? [self.noImagesLabel setHidden:YES] : [self.noImagesLabel setHidden:NO];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.arrayWithImages.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UserImagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserImagesCollectionViewCell" forIndexPath:indexPath];
    cell.imageCollectionViewOutlet.image = self.arrayWithImages[indexPath.row];
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
                                       handler:^(UIAlertAction * _Nonnull action) {
                                           
                                           
                                       }];
        
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

@end
