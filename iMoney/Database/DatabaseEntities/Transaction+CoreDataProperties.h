//
//  Transaction+CoreDataProperties.h
//  
//
//  Created by Alex on 4/23/17.
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
@property (nullable, nonatomic, retain) Wallet *wallet;
@property (nullable, nonatomic, retain) Budget *budget;

@end

NS_ASSUME_NONNULL_END
