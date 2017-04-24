//
//  Debt+CoreDataProperties.h
//  
//
//  Created by Alex on 4/24/17.
//
//

#import "Debt+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Debt (CoreDataProperties)

+ (NSFetchRequest<Debt *> *)fetchRequest;

@property (nonatomic) int16_t debtType;
@property (nullable, nonatomic, copy) NSString *debtName;
@property (nullable, nonatomic, copy) NSString *debtDescription;
@property (nullable, nonatomic, copy) NSDecimalNumber *debtTotalAmount;
@property (nullable, nonatomic, copy) NSDate *debtStartDate;
@property (nullable, nonatomic, copy) NSDate *debtFinishDate;
@property (nonatomic) int32_t debtSort;
@property (nullable, nonatomic, copy) NSDate *debtCreationDate;
@property (nullable, nonatomic, copy) NSDecimalNumber *debtCurrentAmount;
@property (nullable, nonatomic, retain) Wallet *wallet;
@property (nullable, nonatomic, retain) NSSet<Transaction *> *transactions;

@end

@interface Debt (CoreDataGeneratedAccessors)

- (void)addTransactionsObject:(Transaction *)value;
- (void)removeTransactionsObject:(Transaction *)value;
- (void)addTransactions:(NSSet<Transaction *> *)values;
- (void)removeTransactions:(NSSet<Transaction *> *)values;

@end

NS_ASSUME_NONNULL_END
