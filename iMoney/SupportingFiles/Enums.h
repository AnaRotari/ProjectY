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
    kAddWallet = 0,
    kEditWallt
};

typedef NS_ENUM(NSInteger, TransactionCategory)
{
    kTransactionCategoryFoodAndDrinks = 0,
    kTransactionCategoryShopping,
    kTransactionCategoryHousing,
    kTransactionCategoryTransportation,
    kTransactionCategoryVechicle,
    kTransactionCategoryLifeAndEntertainments,
    kTransactionCategoryPC,
    kTransactionCategoryFinancialExpenses,
    kTransactionCategoryInvestments,
    kTransactionCategoryIncome,
    kTransactionCategoryGregories,
    kTransactionCategoryOther
};

typedef NS_ENUM(NSInteger, PaymentType)
{
    kPaymentTypeCash = 0,
    kPaymentTypeDebitCard,
    kPaymentTypeCreditCard,
    kPaymentTypeBankTransfer,
    kPaymentTypeVouvher,
    kPaymentTypeMobilePayment,
    kPaymentTypeWebPayment
};

typedef NS_ENUM(NSInteger, TransactionType)
{
    kTransactionTypeIncome = 0,
    kTransactionTypeExpense
};

#endif /* Enums_h */
