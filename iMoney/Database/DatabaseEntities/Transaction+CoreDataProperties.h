//
//  Transaction+CoreDataProperties.h
//  
//
//  Created by Alex on 4/24/17.
//
//

#import "Transaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Transaction (CoreDataProperties)

+ (NSFetchRequest<Transaction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *transactionAmount;
@property (nullable, nonatomic, retain) NSData *transactionAttachments;
@property (nonatomic) int32_t transactionCategory;
@property (nullable, nonatomic, copy) NSDate *transactionDate;
@property (nullable, nonatomic, copy) NSString *transactionDescription;
@property (nonatomic) double transactionLatitude;
@property (nonatomic) double transactionLongitude;
@property (nullable, nonatomic, copy) NSString *transactionPayee;
@property (nonatomic) int32_t transactionPaymentType;
@property (nonatomic) int32_t transactionType;
@property (nullable, nonatomic, copy) NSDate *transactionWarrienty;
@property (nullable, nonatomic, retain) NSSet<Budget *> *budget;
@property (nullable, nonatomic, retain) Wallet *wallet;
@property (nullable, nonatomic, retain) Debt *debt;

@end

@interface Transaction (CoreDataGeneratedAccessors)

- (void)addBudgetObject:(Budget *)value;
- (void)removeBudgetObject:(Budget *)value;
- (void)addBudget:(NSSet<Budget *> *)values;
- (void)removeBudget:(NSSet<Budget *> *)values;

@end

NS_ASSUME_NONNULL_END
