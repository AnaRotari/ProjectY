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
@property (nullable, nonatomic, copy) NSDecimalNumber *debtAmount;
@property (nullable, nonatomic, copy) NSDate *debtStartDate;
@property (nullable, nonatomic, copy) NSDate *debtFinishDate;
@property (nullable, nonatomic, retain) Wallet *wallet;

@end

NS_ASSUME_NONNULL_END
