//
//  Wallet+CoreDataProperties.h
//  
//
//  Created by Alex on 3/23/17.
//
//

#import "Wallet+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Wallet (CoreDataProperties)

+ (NSFetchRequest<Wallet *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *walletID;
@property (nonatomic) double walletInitialBalance;
@property (nullable, nonatomic, copy) NSString *walletCurrency;
@property (nullable, nonatomic, copy) NSString *walletName;
@property (nullable, nonatomic, copy) NSString *walletDescription;

@end

NS_ASSUME_NONNULL_END
