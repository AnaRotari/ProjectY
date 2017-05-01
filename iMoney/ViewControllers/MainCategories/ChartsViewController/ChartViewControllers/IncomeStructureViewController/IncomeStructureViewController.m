//
//  IncomeStructureViewController.m
//  iMoney
//
//  Created by Alex on 5/1/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "IncomeStructureViewController.h"

@interface IncomeStructureViewController ()

@property (strong, nonatomic) NSArray <Wallet *> *walletsArray;
@property (strong, nonatomic) NSString *walletName;
@property (assign, nonatomic) NSInteger selectedWalletIndex;

@property (strong, nonatomic) NSMutableArray <Transaction *> *dataSourceForPlot;
@property (strong, nonatomic) NSMutableArray <NSDictionary *> *structuredDataSourceForPlot;

@end

@implementation IncomeStructureViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Income structure";
    
    [self setUpSortButtons];
    
    self.dataSourceForPlot = [NSMutableArray array];
    self.structuredDataSourceForPlot = [NSMutableArray array];
    
    self.walletsArray = [CoreDataRequestManager getAllWallets];
    self.walletName = self.walletsArray[self.selectedWalletIndex].walletName;
    
    [self setupPieChart];
    
    [self reloadDataForSortOption:kSortOptionShowAll];
}

- (void)setupPieChart {
    
    self.incomePieChart = [[PieChart alloc] initWithFrame:self.supportView.bounds];
    [self.incomePieChart setDataSource:self];
    [self.incomePieChart setDelegate:self];
    [self.incomePieChart setLegendViewType:LegendTypeHorizontal];
    [self.incomePieChart setShowCustomMarkerView:TRUE];
    [self.incomePieChart drawPieChart];
    self.incomePieChart.showValueOnPieSlice = NO;
    [self.supportView addSubview:self.incomePieChart];
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
    
    [self.dataSourceForPlot removeAllObjects];
    [self.structuredDataSourceForPlot removeAllObjects];
    
    [tranasactions enumerateObjectsUsingBlock:^(Transaction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.transactionType == kTransactionTypeIncome) {
            [self.dataSourceForPlot addObject:obj];
        }
    }];

    NSMutableDictionary *valuesDict = [NSMutableDictionary dictionary];
    
    for (Transaction *obj in self.dataSourceForPlot) {
        
        if (![valuesDict objectForKey:[iMoneyUtils getCategoryName:obj.transactionCategory]])
        {
            [valuesDict setObject:obj.transactionAmount forKey:[iMoneyUtils getCategoryName:obj.transactionCategory]];
        }
        else
        {
            NSDecimalNumber *indermediate = [valuesDict objectForKey:[iMoneyUtils getCategoryName:obj.transactionCategory]];
            indermediate = [indermediate decimalNumberByAdding:obj.transactionAmount];
            [valuesDict setObject:indermediate forKey:[iMoneyUtils getCategoryName:obj.transactionCategory]];
        }
    }
    
    [valuesDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [self.structuredDataSourceForPlot addObject:@{key:obj}];
    }];
    
    [self.incomePieChart reloadPieChart];
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

#pragma mark - PieChartDataSource

- (NSInteger)numberOfValuesForPieChart{
    return self.structuredDataSourceForPlot.count;
}

- (UIColor *)colorForValueInPieChartWithIndex:(NSInteger)lineNumber{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    return randColor;
}

- (NSString *)titleForValueInPieChartWithIndex:(NSInteger)index{
    
    return [NSString stringWithFormat:@"%@",[[self.structuredDataSourceForPlot[index] allKeys] firstObject]];
}

- (NSNumber *)valueInPieChartWithIndex:(NSInteger)index{
    
    NSString *key = [[self.structuredDataSourceForPlot[index] allKeys] firstObject];
    return [self.structuredDataSourceForPlot[index] objectForKey:key];
}

- (UIView *)customViewForPieChartTouchWithValue:(NSNumber *)value{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setCornerRadius:4.0F];
    [view.layer setBorderWidth:1.0F];
    [view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShadowRadius:2.0F];
    [view.layer setShadowOpacity:0.3F];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:[NSString stringWithFormat:@"Amount:%@ %@",self.walletsArray[self.selectedWalletIndex].walletCurrency, value]];
    
    float widthIs = [label.text boundingRectWithSize:label.frame.size
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{ NSFontAttributeName:label.font }
                                             context:nil].size.width;
    
    [label setFrame:CGRectMake(0, 0, widthIs + 16, 30)];
    [view addSubview:label];
    
    [view setFrame:label.frame];
    return view;
}

@end
