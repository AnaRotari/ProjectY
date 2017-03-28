//
//  Transaction+CoreDataProperties.h
//  
//
//  Created by Alexandr Pavlov on 3/28/17.
//
//

#import "Transaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Transaction (CoreDataProperties)

+ (NSFetchRequest<Transaction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *transactionAmount;
@property (nullable, nonatomic, copy) NSString *transactionAttachments;
@property (nonatomic) int32_t transactionCategory;
@property (nullable, nonatomic, copy) NSDate *transactionDate;
@property (nullable, nonatomic, copy) NSString *transactionDescription;
@property (nullable, nonatomic, retain) NSObject *transactionLocation;
@property (nullable, nonatomic, copy) NSString *transactionPayee;
@property (nonatomic) int32_t transactionPaymentType;
@property (nonatomic) int32_t transactionType;
@property (nullable, nonatomic, retain) Wallet *wallet;

@end

NS_ASSUME_NONNULL_END
