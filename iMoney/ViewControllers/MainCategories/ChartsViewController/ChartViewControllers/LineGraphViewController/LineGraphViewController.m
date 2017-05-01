//
//  LineGraphViewController.m
//  iMoney
//
//  Created by Alex on 4/30/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "LineGraphViewController.h"

@interface LineGraphViewController ()

@property (strong, nonatomic) NSArray <Wallet *> *walletsArray;
@property (strong, nonatomic) NSString *walletName;
@property (assign, nonatomic) NSInteger selectedWalletIndex;

@property (strong, nonatomic) NSArray <Transaction *> *dataSourceForPlot;

@end

@implementation LineGraphViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Balance trend";
    [self setupGraph];
    [self setUpSortButtons];
    
    self.dataSourceForPlot = [NSArray array];
    
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
    [self.graphView reloadGraph];
    
    __block float maximumValue = 0;
    __block float minimumValue = 0;
    __block float averageValue = 0;
    
    [self.dataSourceForPlot enumerateObjectsUsingBlock:^(Transaction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (obj.transactionType) {
            case kTransactionTypeIncome:
                
                if (obj.transactionAmount.floatValue > maximumValue) {
                    maximumValue = obj.transactionAmount.floatValue;
                }
                
                break;
            case kTransactionTypeExpense:
                
                if (obj.transactionAmount.floatValue > minimumValue) {
                    minimumValue = obj.transactionAmount.floatValue * -1;
                }
                
                break;
            default:
                break;
        }
        
        averageValue += obj.transactionAmount.floatValue;
    }];
    
    averageValue = averageValue / self.dataSourceForPlot.count;
    
    self.minLabel.text = [NSString stringWithFormat:@"%@ %.2f",self.walletsArray[self.selectedWalletIndex].walletCurrency,minimumValue];
    self.maxLabel.text = [NSString stringWithFormat:@"%@ +%.2f",self.walletsArray[self.selectedWalletIndex].walletCurrency,maximumValue];
    self.averageLabel.text = [NSString stringWithFormat:@"%@ ~%.2f",self.walletsArray[self.selectedWalletIndex].walletCurrency,averageValue];
}

#pragma mark - Data manipulation

- (void)setupGraph {
    
    // Create a gradient to apply to the bottom portion of the graph
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    
    // Apply the gradient to the bottom portion of the graph
    self.graphView.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);

    // Enable and disable various graph properties and axis displays
    self.graphView.enableTouchReport = YES;
    self.graphView.enablePopUpReport = YES;
    self.graphView.enableYAxisLabel = YES;
    self.graphView.autoScaleYAxis = YES;
    self.graphView.alwaysDisplayDots = NO;
    self.graphView.enableReferenceXAxisLines = YES;
    self.graphView.enableReferenceYAxisLines = YES;
    self.graphView.enableReferenceAxisFrame = YES;
    
    // Set the graph's animation style to draw, fade, or none
    self.graphView.animationGraphStyle = BEMLineAnimationDraw;
    
    // Dash the y reference lines
    self.graphView.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
    
    // Show the y axis values with this format string
    self.graphView.formatStringForValues = @"%.1f";
}

#pragma mark - BEMSimpleLineGraphDataSource

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    
    return self.dataSourceForPlot.count;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    
    return self.dataSourceForPlot[index].transactionAmount.floatValue;
}

#pragma mark - BEMSimpleLineGraphDelegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    
    return 2;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    
    return [iMoneyUtils formatDate:self.dataSourceForPlot[index].transactionDate];
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
