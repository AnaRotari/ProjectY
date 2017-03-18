//
//  Test+CoreDataProperties.h
//  
//
//  Created by Alex on 3/18/17.
//
//

#import "Test+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Test (CoreDataProperties)

+ (NSFetchRequest<Test *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *testAttribute;

@end

NS_ASSUME_NONNULL_END
