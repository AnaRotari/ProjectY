//
//  PlannedPaymentsCreatorViewController.m
//  iMoney
//
//  Created by Alex on 4/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "PlannedPaymentsCreatorViewController.h"

@interface PlannedPaymentsCreatorViewController ()

@property (strong, nonatomic) NSArray *categoryArray;
@property (strong, nonatomic) NSArray *typeArray;
@property (strong, nonatomic) NSArray <Wallet *> *walletsArray;
@property (strong, nonatomic) NSArray *frequencyArray;

@property (assign, nonatomic) NSInteger categoryArrayIndex;
@property (assign, nonatomic) NSInteger typeArrayIndex;
@property (assign, nonatomic) NSInteger walletsArrayIndex;
@property (assign, nonatomic) NSInteger frequencyArrayIndex;

@property (strong, nonatomic) NSDate  *fromDate;


//Pickers
@property (strong, nonatomic) PickerViewController *categoryPickerViewController;
@property (strong, nonatomic) PickerViewController *typePickerViewController;
@property (strong, nonatomic) PickerViewController *datePickerViewController;
@property (strong, nonatomic) PickerViewController *frequencyPickerViewController;
@property (strong, nonatomic) PickerViewController *walletPickerViewController;

@end

@implementation PlannedPaymentsCreatorViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBarButton];
    [self setupDataSources];
    [self setupUI];
    [self addTapGestureRecognizer];
    [self disableSwipe];
}

- (void)setupNavigationBarButton {
    
    UIBarButtonItem *doneNavButton = [iMoneyUtils getNavigationButton:@"ic_checkmark"
                                                               target:self
                                                          andSelector:@selector(doneButtonAction)];
    self.navigationItem.rightBarButtonItems = @[doneNavButton];
}

- (void)setupDataSources {
    
    self.categoryArray = @[@"Food And Drinks", @"Shopping", @"Housing", @"Transportation", @"Vechicle", @"Life And Entertainments", @"PC", @"Financial Expenses", @"Investments", @"Income", @"Gregories", @"Sale", @"Other"];
    
    self.typeArray = @[@"Income",
                       @"Expense"];
    
    self.fromDate = [iMoneyUtils getTodayFormatedDate];
    
    self.frequencyArray = @[@"Repeat daily",@"Repeat weekly",@"Repeat monthly",@"Repeat yearly"];
    
    self.walletsArray = [CoreDataRequestManager getAllWallets];
}

- (void)setupUI {
    
    if (self.plannedPayment.plannedName != nil) {
        
        
        self.plannedNameTextField.text = self.plannedPayment.plannedName;
        self.plannedDescriptionTextField.text = self.plannedPayment.plannedDescription;
        self.plannedAmountTextField.text = [NSString stringWithFormat:@"%f",self.plannedPayment.plannedAmount.doubleValue];
        self.plannedCategoryLabel.text = self.categoryArray[self.plannedPayment.plannedCategory];
        self.plannedTypeLabel.text = self.typeArray[self.plannedPayment.plannedType];
        self.planedFromDateLabel.text = [iMoneyUtils formatDate:self.plannedPayment.plannedDate];
        self.plannedFrequencyLabel.text = self.frequencyArray[self.plannedPayment.plannedFrequency];
        
        for (Wallet *wallet in self.walletsArray) {
            
            if ([wallet isEqual:self.plannedPayment.wallet]) {
                self.plannedWalletLabel.text = wallet.walletName;
            }
            break;
        }
    } else {
        
        self.categoryArrayIndex = 12;
        self.typeArrayIndex = 0;
        self.walletsArrayIndex = 0;
        self.frequencyArrayIndex = 2;
        
        self.plannedCategoryLabel.text = self.categoryArray[self.categoryArrayIndex];
        self.plannedTypeLabel.text = self.typeArray[self.typeArrayIndex];
        self.planedFromDateLabel.text = [iMoneyUtils formatDate:self.fromDate];
        self.plannedFrequencyLabel.text = self.frequencyArray[self.frequencyArrayIndex];
        self.plannedWalletLabel.text = self.walletsArray[self.walletsArrayIndex].walletName;
    }
}

- (void)addTapGestureRecognizer {
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandlerMethod)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)gestureHandlerMethod {
    
    [self.view endEditing:YES];
}

#pragma mark - Button actions

- (void)doneButtonAction {
    
    [CoreDataPlannedPaymentsManager savePlannedPayment:self.plannedPayment
                                              withData:@{@"plannedAmount":self.plannedAmountTextField.text,
                                                         @"plannedCategory":@(self.categoryArrayIndex),
                                                         @"plannedDate":self.fromDate,
                                                         @"plannedDescription":self.plannedDescriptionTextField.text,
                                                         @"plannedFrequency":@(self.frequencyArrayIndex),
                                                         @"plannedName":self.plannedNameTextField.text,
                                                         @"plannedType":@(self.typeArrayIndex),
                                                         @"plannedWallet":self.walletsArray[self.walletsArrayIndex]}];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)categoryButtonAction:(id)sender {
    
    if (self.categoryPickerViewController == nil) {
        self.categoryPickerViewController = [[PickerViewController alloc] initFromNib];
        self.categoryPickerViewController.pickerType = CustomPickerType;
        self.categoryPickerViewController.dataSourceForCustomPickerType = self.categoryArray;
        [self.categoryPickerViewController setInitialItemAtIndex:self.categoryArrayIndex];
        self.categoryPickerViewController.delegate = self;
    }
    [self presentViewControllerOverCurrentContext:self.categoryPickerViewController animated:YES completion:nil];
}

- (IBAction)typeButtonAction:(id)sender {
    
    if (self.typePickerViewController == nil) {
        self.typePickerViewController = [[PickerViewController alloc] initFromNib];
        self.typePickerViewController.pickerType = CustomPickerType;
        self.typePickerViewController.dataSourceForCustomPickerType = self.typeArray;
        [self.typePickerViewController setInitialItemAtIndex:self.typeArrayIndex];
        self.typePickerViewController.delegate = self;
    }
    [self presentViewControllerOverCurrentContext:self.typePickerViewController animated:YES completion:nil];
}

- (IBAction)fromDateButtonAction:(id)sender {
    
    if (self.datePickerViewController == nil) {
        self.datePickerViewController = [[PickerViewController alloc] initFromNib];
        self.datePickerViewController.pickerType = DatePickerType;
        self.datePickerViewController.delegate = self;
    }
    [self presentViewControllerOverCurrentContext:self.datePickerViewController animated:YES completion:nil];
}

- (IBAction)frequencyButtonAction:(id)sender {
    
    if (self.frequencyPickerViewController == nil) {
        self.frequencyPickerViewController = [[PickerViewController alloc] initFromNib];
        self.frequencyPickerViewController.pickerType = CustomPickerType;
        self.frequencyPickerViewController.dataSourceForCustomPickerType = self.frequencyArray;
        [self.frequencyPickerViewController setInitialItemAtIndex:self.frequencyArrayIndex];
        self.frequencyPickerViewController.delegate = self;
    }
    [self presentViewControllerOverCurrentContext:self.frequencyPickerViewController animated:YES completion:nil];
}

- (IBAction)walletButtonAction:(id)sender {
    
    if (self.walletPickerViewController == nil) {
        self.walletPickerViewController = [[PickerViewController alloc] initFromNib];
        self.walletPickerViewController.pickerType = CustomPickerType;
        
        NSMutableArray *walletsName = [NSMutableArray array];
        for (Wallet *wallet in self.walletsArray) {
            [walletsName addObject:wallet.walletName];
        }
    
        self.walletPickerViewController.dataSourceForCustomPickerType = walletsName;
        [self.walletPickerViewController setInitialItemAtIndex:self.walletsArrayIndex];
        self.walletPickerViewController.delegate = self;
    }
    [self presentViewControllerOverCurrentContext:self.walletPickerViewController animated:YES completion:nil];
}

#pragma mark - PickerViewControllerDelegate

- (void)didSelectDate:(PickerViewController *)picker date:(NSDate *)date formattedString:(NSString *)dateString {
    
    if ([picker isEqual:self.datePickerViewController]) {
    
        self.fromDate = [self getTodayFormatedDate:date];
        self.planedFromDateLabel.text = [iMoneyUtils formatDate:self.fromDate];
    }
}

- (void)didSelectItemAtIndex:(PickerViewController *)picker index:(NSUInteger)index {
    
    if ([picker isEqual:self.categoryPickerViewController]) {
    
        self.categoryArrayIndex = index;
        self.plannedCategoryLabel.text = self.categoryArray[self.categoryArrayIndex];
    }
    if ([picker isEqual:self.typePickerViewController]) {
        
        self.typeArrayIndex = index;
        self.plannedTypeLabel.text = self.typeArray[self.typeArrayIndex];
    }
    if ([picker isEqual:self.frequencyPickerViewController]) {
        
        self.frequencyArrayIndex = index;
        self.plannedFrequencyLabel.text = self.frequencyArray[self.frequencyArrayIndex];
    }
    if ([picker isEqual:self.walletPickerViewController]) {
        
        self.walletsArrayIndex = index;
        self.plannedWalletLabel.text = self.walletsArray[self.walletsArrayIndex].walletName;
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    
    [super willMoveToParentViewController:parent];
}

- (void)disableSwipe {
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (NSDate *)getTodayFormatedDate:(NSDate *)currentDate {
    
    //Convert date to yy/mm/dd
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay fromDate:currentDate];
    currentDate = [gregorian dateFromComponents:components];
    return currentDate;
}

@end
