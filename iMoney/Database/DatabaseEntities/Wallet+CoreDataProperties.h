//
//  Wallet+CoreDataProperties.h
//  
//
//  Created by Alex on 3/26/17.
//
//

#import "Wallet+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Wallet (CoreDataProperties)

+ (NSFetchRequest<Wallet *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *walletColor;
@property (nullable, nonatomic, copy) NSString *walletCurrency;
@property (nullable, nonatomic, copy) NSString *walletDescription;
@property (nullable, nonatomic, copy) NSString *walletID;
@property (nullable, nonatomic, copy) NSDecimalNumber *walletBalance;
@property (nullable, nonatomic, copy) NSString *walletName;
@property (nonatomic) int64_t walletSort;

@end

NS_ASSUME_NONNULL_END
