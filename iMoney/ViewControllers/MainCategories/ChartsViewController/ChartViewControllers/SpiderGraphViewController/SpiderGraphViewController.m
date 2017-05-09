//
//  SpiderGraphViewController.m
//  iMoney
//
//  Created by Alex on 5/1/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "SpiderGraphViewController.h"
#import "BTSpiderPlotterView.h"

@interface SpiderGraphViewController ()

@property (strong, nonatomic) NSArray <Wallet *> *walletsArray;
@property (strong, nonatomic) NSString *walletName;
@property (assign, nonatomic) NSInteger selectedWalletIndex;

@property (strong, nonatomic) NSArray <Transaction *> *dataSourceForPlot;

@property (strong, nonatomic) BTSpiderPlotterView *spiderView;

@end

@implementation SpiderGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Radar chart";
    
    [self setUpSortButtons];
    
    self.dataSourceForPlot = [NSArray array];
    [self.walletsDropDownMenu setDropdownCornerRadius:5.f];
    self.walletsArray = [CoreDataRequestManager getAllWallets];
    self.walletName = self.walletsArray[self.selectedWalletIndex].walletName;
    
    [self reloadDataForSortOption:kSortOptionShowAll];
}

-(void)setUpSortButtons{
    
    UIBarButtonItem *sortButtonByDate = [iMoneyUtils getNavigationButton:@"ic_sort"
                                                                  target:self
                                                             andSelector:@selector(sortButtonActionByDate:)];
    
    self.navigationItem.rightBarButtonItem = sortButtonByDate;
}

- (void)sortButtonActionByDate:(UIBarButtonItem *)sender {
    
    [self.walletsDropDownMenu closeAllComponentsAnimated:YES];
    [self showSortActionSheet:@[@"Show all",@"Show today",@"Show last week",@"Show last month",@"Show last year"]];
}

- (void)reloadDataForSortOption:(SortOptions)option {
    
    NSArray <Transaction *> *transactions = [[CoreDataRequestManager getAllTransactionForWallet:self.walletsArray[self.selectedWalletIndex]
                                                                                 withSortOption:option] mutableCopy];
    [self generatePlotValues:transactions];
}

-(void)reloadContentForWallet:(NSInteger)walletIndex{
    
    if (self.walletsArray.count == 0) {return;}
    
    NSArray <Transaction*> *transactions;
    Wallet *wallet = self.walletsArray[walletIndex];
    transactions = [CoreDataRequestManager getAllTransactionForWallet:wallet];
    [self generatePlotValues:transactions];
}

- (void)generatePlotValues:(NSArray <Transaction *> *)tranasactions {
    
    self.dataSourceForPlot = tranasactions;
    
    __block int food = 0;
    __block int shopping = 0;
    __block int housing = 0;
    __block int transport = 0;
    __block int vechicle = 0;
    __block int life = 0;
    __block int pc = 0;
    __block int financial = 0;
    __block int invest = 0;
    __block int income = 0;
    __block int gregories = 0;
    __block int sale = 0;
    __block int debts = 0;
    __block int other = 0;
    
    [self.dataSourceForPlot enumerateObjectsUsingBlock:^(Transaction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        switch (obj.transactionCategory) {
            case kTransactionCategoryFoodAndDrinks:
                food ++;
                break;
            case kTransactionCategoryShopping:
                shopping ++;
                break;
            case kTransactionCategoryHousing:
                housing ++;
                break;
            case kTransactionCategoryTransportation:
                transport ++;
                break;
            case kTransactionCategoryVechicle:
                vechicle ++;
                break;
            case kTransactionCategoryLifeAndEntertainments:
                life ++;
                break;
            case kTransactionCategoryPC:
                pc ++;
                break;
            case kTransactionCategoryFinancialExpenses:
                financial ++;
                break;
            case kTransactionCategoryInvestments:
                invest ++;
                break;
            case kTransactionCategoryIncome:
                income ++;
                break;
            case kTransactionCategoryGregories:
                gregories ++;
                break;
            case kTransactionCategorySale:
                sale ++;
                break;
            case kTransactionCategoryOther:
                other ++;
                break;
            case kTransactionCategoryDebts:
                debts ++;
                break;
                
            default:
                break;
        }
    }];

    NSArray <NSNumber *> *fukingArray = @[@(food),@(shopping),@(housing),@(transport),@(vechicle),@(life),@(pc),@(financial),@(invest),@(income),@(gregories),@(sale),@(debts),@(other)];
    
    __block int maximum = 0;
    
    [fukingArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.intValue > maximum) {
            maximum = obj.intValue;
        }
    }];
    
    [self.spiderView setMaxValue:maximum];
    
    NSDictionary *valueDictionary = @{@"Food"      : [NSString stringWithFormat:@"%d",food],
                                      @"Shopping"  : [NSString stringWithFormat:@"%d",shopping],
                                      @"Housing"   : [NSString stringWithFormat:@"%d",housing],
                                      @"Transport" : [NSString stringWithFormat:@"%d",transport],
                                      @"Vechicle"  : [NSString stringWithFormat:@"%d",vechicle],
                                      @"Life"      : [NSString stringWithFormat:@"%d",life],
                                      @"PC"        : [NSString stringWithFormat:@"%d",pc],
                                      @"Financial" : [NSString stringWithFormat:@"%d",financial],
                                      @"Invest"    : [NSString stringWithFormat:@"%d",invest],
                                      @"Income"    : [NSString stringWithFormat:@"%d",income],
                                      @"Gregories" : [NSString stringWithFormat:@"%d",gregories],
                                      @"Sale"      : [NSString stringWithFormat:@"%d",sale],
                                      @"Debts"     : [NSString stringWithFormat:@"%d",debts],
                                      @"Other"     : [NSString stringWithFormat:@"%d",other]};
    
    [self reloadSpiderView:valueDictionary];
}

- (void)reloadSpiderView:(NSDictionary *)values {
    
    if (self.spiderView)
    {
        [self.spiderView removeFromSuperview];
        self.spiderView = nil;
    }
    self.spiderView = [[BTSpiderPlotterView alloc] initWithFrame:self.supportView.bounds valueDictionary:values];
    self.spiderView.plotColor = [UIColor colorWithRed:42/255.f green:3/255.f blue:70/255.f alpha:1];
    self.spiderView.drawboardColor = [UIColor colorWithRed:33/255.f green:33/255.f blue:33/255.f alpha:1];
    [self.supportView addSubview:self.spiderView];
}

#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    
    return self.walletsArray.count;
}

#pragma mark - MKDropdownMenuDelegate

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component {
    return self.walletName;
}

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.walletsArray[row].walletName;
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.walletName = self.walletsArray[row].walletName;
    self.selectedWalletIndex = row;
    
    [dropdownMenu closeAllComponentsAnimated:YES];
    [dropdownMenu reloadComponent:component];
    [self reloadContentForWallet:self.selectedWalletIndex];
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [self reloadDataForSortOption:buttonIndex];
    }
}

@end
