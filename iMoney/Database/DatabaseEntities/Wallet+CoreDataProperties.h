//
//  Wallet+CoreDataProperties.h
//  
//
//  Created by Alex on 4/23/17.
//
//

#import "Wallet+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Wallet (CoreDataProperties)

+ (NSFetchRequest<Wallet *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *walletBalance;
@property (nullable, nonatomic, retain) NSData *walletColor;
@property (nullable, nonatomic, copy) NSString *walletCurrency;
@property (nullable, nonatomic, copy) NSString *walletDescription;
@property (nullable, nonatomic, copy) NSString *walletID;
@property (nullable, nonatomic, copy) NSString *walletName;
@property (nonatomic) int64_t walletSort;
@property (nullable, nonatomic, retain) NSSet<PlannedPayments *> *plannedPayment;
@property (nullable, nonatomic, retain) NSSet<Transaction *> *transactions;
@property (nullable, nonatomic, retain) Budget *budget;

@end

@interface Wallet (CoreDataGeneratedAccessors)

- (void)addPlannedPaymentObject:(PlannedPayments *)value;
- (void)removePlannedPaymentObject:(PlannedPayments *)value;
- (void)addPlannedPayment:(NSSet<PlannedPayments *> *)values;
- (void)removePlannedPayment:(NSSet<PlannedPayments *> *)values;

- (void)addTransactionsObject:(Transaction *)value;
- (void)removeTransactionsObject:(Transaction *)value;
- (void)addTransactions:(NSSet<Transaction *> *)values;
- (void)removeTransactions:(NSSet<Transaction *> *)values;

@end

NS_ASSUME_NONNULL_END
