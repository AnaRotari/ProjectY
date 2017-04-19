//
//  PlannedPayments+CoreDataProperties.h
//  
//
//  Created by Alex on 4/20/17.
//
//

#import "PlannedPayments+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PlannedPayments (CoreDataProperties)

+ (NSFetchRequest<PlannedPayments *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *plannedAmount;
@property (nonatomic) int16_t plannedCategory;
@property (nullable, nonatomic, copy) NSDate *plannedDate;
@property (nullable, nonatomic, copy) NSString *plannedDescription;
@property (nonatomic) int16_t plannedFrequency;
@property (nullable, nonatomic, copy) NSString *plannedName;
@property (nonatomic) int16_t plannedType;
@property (nonatomic) int16_t plannedSort;
@property (nullable, nonatomic, retain) Wallet *wallet;

@end

NS_ASSUME_NONNULL_END
