//
//  Enums.h
//  iMoney
//
//  Created by Alex on 3/25/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

#ifndef Enums_h
#define Enums_h

typedef NS_ENUM(NSInteger, AddEditWallet)
{
    kAddWallet,
    kEditWallt
};

typedef NS_ENUM(NSInteger, TransactionCategory)
{
    kTransactionCategoryFoodAndDrinks,
    kTransactionCategoryShopping,
    kTransactionCategoryHousing,
    kTransactionCategoryTransportation,
    kTransactionCategoryVechicle,
    kTransactionCategoryLifeAndEntertainments,
    kTransactionCategoryPC,
    kTransactionCategoryFinancialExpenses,
    kTransactionCategoryInvestments,
    kTransactionCategoryIncome,
    kTransactionCategoryOther
};

typedef NS_ENUM(NSInteger, PaymentType)
{
    kPaymentTypeCash,
    kPaymentTypeDebitCard,
    kPaymentTypeCreditCard,
    kPaymentTypeBankTransfer,
    kPaymentTypeVouvher,
    kPaymentTypeMobilePayment,
    kPaymentTypeWebPayment
};

typedef NS_ENUM(NSInteger, TransactionType)
{
    kTransactionTypeIncome,
    kTransactionTypeExpense,
    kTransactionTypeTransfer
};

#endif /* Enums_h */
