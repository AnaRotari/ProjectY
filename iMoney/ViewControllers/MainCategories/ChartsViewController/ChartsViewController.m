//
//  ChartsViewController.m
//  iMoney
//
//  Created by Alex on 4/7/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ChartsViewController.h"
#import "ChartTableViewCell.h"
#import "LineGraphViewController.h"
#import "SpiderGraphViewController.h"
#import "ExpensesStructureViewController.h"
#import "IncomeStructureViewController.h"

@interface ChartsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *chartPreviewTableView;

@property (strong, nonatomic) NSArray <NSDictionary <NSString *,NSString *> *> *chartTypeIdentifierArray;

@end

@implementation ChartsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.chartPreviewTableView registerNib:[UINib nibWithNibName:@"ChartTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChartTableViewCell"];
    self.chartPreviewTableView.tableFooterView = [UIView new];
    
    self.chartTypeIdentifierArray = @[@{@"PlotName":@"Balance trend",@"StoryboardIdentifier":@"LineGraphViewController",@"PreviewImage":@"ic_balanceTrend"},
                                      @{@"PlotName":@"Radar chart",@"StoryboardIdentifier":@"SpiderGraphViewController",@"PreviewImage":@"ic_spider"},
                                      @{@"PlotName":@"Income structure",@"StoryboardIdentifier":@"IncomeStructureViewController",@"PreviewImage":@"ic_piechart_1"},
                                      @{@"PlotName":@"Expense structure",@"StoryboardIdentifier":@"ExpensesStructureViewController",@"PreviewImage":@"ic_piechart_2"},];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.chartTypeIdentifierArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChartTableViewCell" forIndexPath:indexPath];
    cell.chartNameLabel.text = self.chartTypeIdentifierArray[indexPath.row][@"PlotName"];
    cell.chartPreviewImage.image = [UIImage imageNamed:self.chartTypeIdentifierArray[indexPath.row][@"PreviewImage"]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushToViewController:self.chartTypeIdentifierArray[indexPath.row][@"StoryboardIdentifier"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 86;
}

- (void)pushToViewController:(NSString *)viewControllerIdentifier {
    
    if ([CoreDataRequestManager getAllTransactions].count > 0 && [CoreDataRequestManager getAllTransactions].count > 0)
    {
        if ([viewControllerIdentifier isEqualToString:@"LineGraphViewController"]) {
            LineGraphViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"LineGraphViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if ([viewControllerIdentifier isEqualToString:@"SpiderGraphViewController"]) {
            LineGraphViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SpiderGraphViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if ([viewControllerIdentifier isEqualToString:@"IncomeStructureViewController"]) {
            IncomeStructureViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"IncomeStructureViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if ([viewControllerIdentifier isEqualToString:@"ExpensesStructureViewController"]) {
            LineGraphViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ExpensesStructureViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    else
    {
        [iMoneyUtils showAlertView:@"Alert" withMessage:@"You need to create a transactions first !"];
    }
}

@end
