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
    [self initUIWithTransaction:self.transactionDetail];
    
    self.totalWallets = [CoreDataRequestManager getAllWalletsWithoutWallet:self.transactionDetail.wallet];
}

#pragma mark - Initializations

- (void)initUIWithTransaction:(Transaction *)transaction {
    
    self.attachmentsArray = [[NSArray alloc] arrayWithData:self.transactionDetail.transactionAttachments];
    self.attachmentsArray.count ? [self.noImagesLabel setHidden:YES] : [self.noImagesLabel setHidden:NO];
    
    [self.attachmentsCollectionView registerNib:[UINib nibWithNibName:@"UserImagesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"UserImagesCollectionViewCell"];
    
    [self labelsSetup];
}

- (void)labelsSetup {
    
    switch (self.transactionDetail.transactionType) {
        case kTransactionTypeIncome:
            [self.segmentedButtons setSelectedSegmentIndex:0];
            break;
        case kTransactionTypeExpense:
            [self.segmentedButtons setSelectedSegmentIndex:1];
            break;
        default:
            break;
    }
    
    self.transactionAmountLabel.text   = [self.transactionDetail.transactionAmount stringValue];
    self.transactionCategoryLabel.text = [iMoneyUtils getCategoryName:self.transactionDetail.transactionCategory];
    self.transactionDateLabel.text     = [iMoneyUtils formatDate:self.transactionDetail.transactionDate];
    self.transactionDescription.text   = self.transactionDetail.transactionDescription;
    self.transactionPayee.text         = self.transactionDetail.transactionPayee;
    self.transactionPaymentsType.text  = [iMoneyUtils getTransactionTypeName:self.transactionDetail.transactionPaymentType];
}

#pragma mark - Segmented Controll

- (void)segmentControllSetup {
    
    [self.segmentedButtons setSegmentsColor];
    [self.segmentedButtons setFonts];
}

- (IBAction)segmentControlAction:(HistorySegmentedControl *)sender {
    
    int tag = (int)[sender selectedSegmentIndex];
    if (tag != self.transactionDetail.transactionType) {
        [self showChangeAlert:tag];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.attachmentsArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UserImagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserImagesCollectionViewCell" forIndexPath:indexPath];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *videoFolderPath = [paths firstObject];
    videoFolderPath = [NSString stringWithFormat:@"%@/%@/%@.png", videoFolderPath, kAppFolder, self.attachmentsArray[indexPath.row]];
    NSData *pngData = [NSData dataWithContentsOfFile:videoFolderPath];
    UIImage *image = [UIImage imageWithData:pngData];
    
    cell.imageCollectionViewOutlet.image = image;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(170,170);
}

#pragma mark - UIAlertController

- (void)showChangeAlert:(TransactionType)type {
    
    UIAlertController *alert = [UIAlertController
                                 alertControllerWithTitle:@"Alert"
                                 message:@"Do you wont to change transaction type ?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) { }];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                   [self changeTransactionType:type];
                               }];
    
    [alert addAction:okButton];
    [alert addAction:cancelButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)changeTransactionType:(TransactionType)selectedType {
    
    switch (selectedType) {
        case kTransactionTypeIncome:
            [self changeToIncome];
            break;
        case kTransactionTypeExpense:
            [self changeToExpense];
            break;
        case kTransactionTypeTransfer:
            [self transferTransaction];
            break;
        default:
            break;
    }
}

- (void)changeToIncome {
    
    self.transactionDetail.transactionType = kTransactionTypeIncome;
    NSDecimalNumber *number = self.transactionDetail.transactionAmount;
    number = [number decimalNumberByAdding:number];
    self.transactionDetail.wallet.walletBalance = [self.transactionDetail.wallet.walletBalance decimalNumberByAdding:number];
    [[CoreDataAccessLayer sharedInstance] saveContext];
}

- (void)changeToExpense {
    
    self.transactionDetail.transactionType = kTransactionTypeExpense;
    NSDecimalNumber *number = self.transactionDetail.transactionAmount;
    number = [number decimalNumberByAdding:number];
    self.transactionDetail.wallet.walletBalance = [self.transactionDetail.wallet.walletBalance decimalNumberBySubtracting:number];
    [[CoreDataAccessLayer sharedInstance] saveContext];
}

- (void)transferTransaction {
    
    if (self.totalWallets.count > 0) {
        [self moveTransactionToWallet:self.totalWallets];
    } else {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"You cant transfer amount if you have less than 1 wallet !"];
    }
}

- (void)moveTransactionToWallet:(NSArray <Wallet *> *)wallets {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"Available wallets";
    actionSheet.delegate = self;
    
    for (Wallet *extractedWallet in wallets) {
        
        [actionSheet addButtonWithTitle:extractedWallet.walletName];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView: self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    Wallet *sourceWallet = self.transactionDetail.wallet;
    Wallet *walletToTransfer = self.totalWallets[buttonIndex];
    
    [CoreDataHelpManager transferTransaction:self.transactionDetail
                            fromSourceWallet:sourceWallet
                         toDestinationWallet:walletToTransfer];
    
    [self labelsSetup];
}

@end
