//
//  ExportsViewController.m
//  iMoney
//
//  Created by Ivan on 4/18/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#import "ExportsViewController.h"
#import <MessageUI/MessageUI.h>
#import "TransactionTableViewCell.h"

@interface ExportsViewController ()<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UIActionSheetDelegate>

@end

@implementation ExportsViewController{
    __weak IBOutlet UITableView *tableViewOutlet;
    NSArray<Wallet*> *wallets;
    NSMutableArray<NSArray<Transaction*>*> *transactions;
    NSArray<NSDate *> *sortedDates;
    __weak IBOutlet UILabel *walletNameLabel;
    __weak IBOutlet UILabel *walletAmountLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtons];
    [self reloadDataForIndex:0];
    [self mainTableViewSetup];
}

- (void)mainTableViewSetup {
    [tableViewOutlet registerNib:[UINib nibWithNibName:@"TransactionTableViewCell" bundle:nil] forCellReuseIdentifier:@"TransactionTableViewCell"];
    tableViewOutlet.tableFooterView = [UIView new];
}

#pragma mark - data manupulate
-(void)reloadDataForIndex:(NSInteger)index{
    wallets = [CoreDataRequestManager getAllWallets];
    NSArray<Transaction*> *allTransactions = [CoreDataRequestManager getAllTransactionForWallet:wallets[index]];
    
    NSMutableSet<NSDate *> *transactionsDates = [NSMutableSet set];
    for (Transaction *transaction in allTransactions) {
        [transactionsDates addObject:transaction.transactionDate];
    }
    
    transactions = [NSMutableArray array];
    
    sortedDates = [transactionsDates.allObjects sortedArrayUsingComparator:^NSComparisonResult(NSDate *obj1, NSDate *obj2) {
        return [obj2 compare:obj1];
    }];
    
    for (NSDate *date in sortedDates) {
        NSMutableArray<Transaction *> *transactionsForDate = [NSMutableArray array];
        for (Transaction *transaction in allTransactions) {
            if ([date compare:transaction.transactionDate] == NSOrderedSame) {
                [transactionsForDate addObject:transaction];
            }
        }
        [transactions addObject:transactionsForDate];
    }
    
    self.title = @"Export";
    
    walletNameLabel.text = wallets[index].walletName;
    walletAmountLabel.text = [NSString stringWithFormat:@"%@ %.2f",wallets[index].walletCurrency,wallets[index].walletBalance.doubleValue];
    
    [tableViewOutlet reloadSections:[NSIndexSet indexSetWithIndex:0]
                   withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - navigation buttons
-(void)setNavigationButtons{
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    UIBarButtonItem *sortWallets = [iMoneyUtils getNavigationButton:@"ic_sort"
                                                             target:self
                                                        andSelector:@selector(sortWallets:)];
    self.navigationItem.rightBarButtonItems = @[shareButton, sortWallets];
}

-(void)share:(UIBarButtonItem *)sender{
    [self showEmail];
}

-(void)sortWallets:(UIBarButtonItem *)sender{
    NSMutableArray<NSString *> *walletsNames = [NSMutableArray array];
    for (Wallet *wallet in wallets) {
        [walletsNames addObject:wallet.walletName];
    }
    [self showSortActionSheet:walletsNames];
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
        [self reloadDataForIndex:buttonIndex];
    }
}

#pragma mark - table view delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return transactions.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return transactions[section].count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDate *date = sortedDates[section];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *formatedDate = [formatter stringFromDate:date];
    
    return formatedDate;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionTableViewCell" forIndexPath:indexPath];
    [cell initTransactionCell:transactions[indexPath.section][indexPath.row] hidesDateLabel:true];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

#pragma mark - create pdf
-(NSData*)makePDFfromView:(UIView*)view
{
    CGRect newTableViewFrame = tableViewOutlet.frame;
    newTableViewFrame.size = tableViewOutlet.contentSize;
    [tableViewOutlet setFrame:newTableViewFrame];
    
    NSMutableData *pdfData = [NSMutableData data];
    
    UIGraphicsBeginPDFContextToData(pdfData, view.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:pdfContext];
    UIGraphicsEndPDFContext();
    
    return pdfData;
}

#pragma mark - send mail methods
- (void)showEmail{
    if ([MFMessageComposeViewController canSendText]) {
#warning add message title and body
        NSString *emailTitle = @"";
        NSString *messageBody = @"";
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        
        NSString *mimeType = @"application/pdf";
        
        // Add attachment
        [mc addAttachmentData:[self makePDFfromView:tableViewOutlet] mimeType:mimeType fileName:@"report"];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    CGRect tableViewFrame = CGRectZero;
    CGFloat navigationHeight = CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    tableViewFrame.origin.x = 0;
    tableViewFrame.origin.y = navigationHeight;
    tableViewFrame.size.width = CGRectGetWidth(self.view.frame);
    tableViewFrame.size.height = CGRectGetHeight(self.view.frame) - navigationHeight;
    [tableViewOutlet setFrame: tableViewFrame];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
