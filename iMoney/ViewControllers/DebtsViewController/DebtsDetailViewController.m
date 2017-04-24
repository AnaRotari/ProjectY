//
//  DebtsDetailViewController.m
//  iMoney
//
//  Created by Alex on 4/24/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "DebtsDetailViewController.h"

@interface DebtsDetailViewController ()

//Pickers
@property (strong, nonatomic) PickerViewController *startDatePickerViewController;
@property (strong, nonatomic) PickerViewController *finishDatePickerViewController;
@property (strong, nonatomic) PickerViewController *typePickerViewController;
@property (strong, nonatomic) PickerViewController *walletPickerViewController;

@property (strong, nonatomic) NSDate *userSelectedStartDate;
@property (strong, nonatomic) NSDate *userSelectedFinishDate;

@property (strong, nonatomic) NSArray *debtTypesArray;
@property (assign, nonatomic) NSInteger selectedDebtType;

@property (strong, nonatomic) NSArray <Wallet *> *walletsArray;
@property (assign, nonatomic) NSInteger selectedwalletsIndex;

@end

@implementation DebtsDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addTapGestureRecognizer];
    [self setupSupportViews];
    [self setUpNavigationControllerButtons];
    [self setupUIWithDebt];
}

- (void)setupSupportViews {
    
    CGFloat onePixel = 1.0 / [UIScreen mainScreen].scale;
    for (UIView *supportView in self.supportViewCollection) {
        supportView.layer.borderWidth = onePixel;
        supportView.layer.borderColor = RGBColor(205, 205, 205, 1).CGColor;
    }
}

- (void)addTapGestureRecognizer {
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandlerMethod)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)gestureHandlerMethod {
    
    [self.view endEditing:YES];
}

- (void)setUpNavigationControllerButtons {
    
    switch (self.debtStatus) {
        case DebtStatusAdd:
            self.title = @"New debt";
            break;
        case DebtStatusEdit:
            self.title = @"Edit debt";
            break;
        default:
            break;
    }
    
    UIBarButtonItem *createDebtsButton = [iMoneyUtils getNavigationButton:@"ic_checkmark"
                                                                   target:self
                                                              andSelector:@selector(createDebtsButtonAction)];
    
    self.navigationItem.rightBarButtonItem = createDebtsButton;
}

- (void)setupUIWithDebt {
    
    self.debtTypesArray = @[@"I lend",@"I borrow"];
    self.walletsArray = [CoreDataRequestManager getAllWallets];
    
    if (self.debtStatus == DebtStatusEdit) {
        
        self.debtNameTextField.text        = self.selectedDebt.debtName;
        self.debtDescriptionTextField.text = self.selectedDebt.debtDescription;
        self.debtAmountTextField.text      = [NSString stringWithFormat:@"%.2f",self.selectedDebt.debtAmount.doubleValue];
        self.walletCurrencyLabel.text      = self.selectedDebt.wallet.walletCurrency;
        self.startDateLabel.text           = [iMoneyUtils formatDate:self.selectedDebt.debtStartDate];
        self.finishDateLabel.text          = [iMoneyUtils formatDate:self.selectedDebt.debtFinishDate];
        self.walletNameLabel.text          = self.selectedDebt.wallet.walletName;
        switch (self.selectedDebt.debtType) {
            case DebtTypeLend:
                self.debtTypeLabel.text = @"I lend";
                break;
            case DebtTypeBorrow:
                self.debtTypeLabel.text = @"I borrow";
                break;
            default:
                break;
        }
    } else {
        
        self.startDateLabel.text  = [iMoneyUtils formatDate:[iMoneyUtils getTodayFormatedDate]];
        self.finishDateLabel.text = [iMoneyUtils formatDate:[iMoneyUtils getTodayFormatedDate]];
        
        self.debtTypeLabel.text = self.debtTypesArray[self.selectedDebtType];
        
        self.walletCurrencyLabel.text = self.walletsArray[self.selectedwalletsIndex].walletCurrency;
        self.walletNameLabel.text     = self.walletsArray[self.selectedwalletsIndex].walletName;
    }
}

- (void)createDebt {
    
    NSDictionary *options = @{};
    [CoreDataDebtManager createDebtWithOptions:options];
}

#pragma mark - Button actions

- (void)createDebtsButtonAction {
    
    switch (self.debtStatus) {
        case DebtStatusEdit:
            [[CoreDataAccessLayer sharedInstance] saveContext];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case DebtStatusAdd:
            [self createDebt];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

- (IBAction)startDateButtonAction:(id)sender {
    
    if (self.startDatePickerViewController == nil) {
        self.startDatePickerViewController = [[PickerViewController alloc] initFromNib];
        self.startDatePickerViewController.pickerType = DatePickerType;
        self.startDatePickerViewController.delegate = self;
    }
    [self presentViewControllerOverCurrentContext:self.startDatePickerViewController animated:YES completion:nil];
}

- (IBAction)finishDateButtonAction:(id)sender {
    
    if (self.finishDatePickerViewController == nil) {
        self.finishDatePickerViewController = [[PickerViewController alloc] initFromNib];
        self.finishDatePickerViewController.pickerType = DatePickerType;
        self.finishDatePickerViewController.delegate = self;
    }
    [self presentViewControllerOverCurrentContext:self.finishDatePickerViewController animated:YES completion:nil];
}

- (IBAction)debtTypeButtonAction:(id)sender {
    
    if (self.typePickerViewController == nil) {
        self.typePickerViewController = [[PickerViewController alloc] initFromNib];
        self.typePickerViewController.pickerType = CustomPickerType;
        self.typePickerViewController.dataSourceForCustomPickerType = self.debtTypesArray;
        [self.typePickerViewController setInitialItemAtIndex:self.selectedDebtType];
        self.typePickerViewController.delegate = self;
    }
    [self presentViewControllerOverCurrentContext:self.typePickerViewController animated:YES completion:nil];
}

- (IBAction)walletButtonAction:(id)sender {
    
    if (self.walletPickerViewController == nil) {
        
        NSMutableArray *arrayWithWalletsName = [[NSMutableArray alloc] init];
        for (Wallet *wallet in self.walletsArray) {
            [arrayWithWalletsName addObject:wallet.walletName];
        }
        
        self.walletPickerViewController = [[PickerViewController alloc] initFromNib];
        self.walletPickerViewController.pickerType = CustomPickerType;
        self.walletPickerViewController.dataSourceForCustomPickerType = arrayWithWalletsName;
        [self.walletPickerViewController setInitialItemAtIndex:self.selectedwalletsIndex];
        self.walletPickerViewController.delegate = self;
    }
    [self presentViewControllerOverCurrentContext:self.walletPickerViewController animated:YES completion:nil];
}

#pragma mark - PickerViewControllerDelegate

- (void)didSelectDate:(PickerViewController *)picker date:(NSDate *)date formattedString:(NSString *)dateString {
    
    if ([picker isEqual:self.startDatePickerViewController]) {
        
        self.userSelectedStartDate = date;
        self.startDateLabel.text = [iMoneyUtils formatDate:date];
    }
    if ([picker isEqual:self.finishDatePickerViewController]) {
        
        self.userSelectedFinishDate = date;
        self.finishDateLabel.text = [iMoneyUtils formatDate:date];
    }
}

- (void)didSelectItemAtIndex:(PickerViewController *)picker index:(NSUInteger)index {
    
    if ([picker isEqual:self.typePickerViewController]) {
        
        self.selectedDebtType = index;
        self.debtTypeLabel.text = self.debtTypesArray[self.selectedDebtType];
    }
    if ([picker isEqual:self.walletPickerViewController]) {
        
        self.selectedwalletsIndex = index;
        self.walletCurrencyLabel.text = self.walletsArray[self.selectedwalletsIndex].walletCurrency;
        self.walletNameLabel.text     = self.walletsArray[self.selectedwalletsIndex].walletName;
    }
}

@end
