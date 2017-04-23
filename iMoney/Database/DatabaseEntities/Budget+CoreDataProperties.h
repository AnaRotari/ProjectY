//
//  Budget+CoreDataProperties.h
//  
//
//  Created by Alex on 4/24/17.
//
//

#import "Budget+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Budget (CoreDataProperties)

+ (NSFetchRequest<Budget *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *budgetCurrentAmount;
@property (nullable, nonatomic, copy) NSDate *budgetFinishDate;
@property (nonatomic) int16_t budgetInterval;
@property (nullable, nonatomic, copy) NSString *budgetName;
@property (nullable, nonatomic, copy) NSDate *budgetStartDate;
@property (nullable, nonatomic, copy) NSDecimalNumber *budgetTotalAmount;
@property (nullable, nonatomic, retain) NSSet<Transaction *> *transactions;
@property (nullable, nonatomic, retain) NSSet<Wallet *> *wallets;

@end

@interface Budget (CoreDataGeneratedAccessors)

- (void)addTransactionsObject:(Transaction *)value;
- (void)removeTransactionsObject:(Transaction *)value;
- (void)addTransactions:(NSSet<Transaction *> *)values;
- (void)removeTransactions:(NSSet<Transaction *> *)values;

- (void)addWalletsObject:(Wallet *)value;
- (void)removeWalletsObject:(Wallet *)value;
- (void)addWallets:(NSSet<Wallet *> *)values;
- (void)removeWallets:(NSSet<Wallet *> *)values;

@end

NS_ASSUME_NONNULL_END
