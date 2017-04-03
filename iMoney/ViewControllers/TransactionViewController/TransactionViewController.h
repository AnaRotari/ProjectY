//
//  TransactionViewController.h
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKDropdownMenu.h"

@interface TransactionViewController : UIViewController <MKDropdownMenuDataSource,MKDropdownMenuDelegate, UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

//Data flow
@property (strong, nonatomic) Wallet *parentWallet;

//Transaction type
@property (weak, nonatomic) IBOutlet MKDropdownMenu *transactionType;
@property (weak, nonatomic) IBOutlet UILabel *selectedTransactionTypeLabel;
@property (strong, nonatomic) NSArray *transactionTypeArray;

//Transaction category
@property (weak, nonatomic) IBOutlet MKDropdownMenu *transactionCategory;
@property (weak, nonatomic) IBOutlet UILabel *selectedTransactionCategoryLabel;
@property (strong, nonatomic) NSArray *transactionCategoryArray;

//Payment type
@property (weak, nonatomic) IBOutlet MKDropdownMenu *paymentType;
@property (weak, nonatomic) IBOutlet UILabel *selectedPaymentTypeLabel;
@property (strong, nonatomic) NSArray *paymentArray;

//Amount
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

//Payee
@property (weak, nonatomic) IBOutlet UITextField *payeeLabel;

//Description
@property (weak, nonatomic) IBOutlet UITextField *descriptionLabel;

//Date label
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

//Collection View
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *noImagesLabel;


@end
