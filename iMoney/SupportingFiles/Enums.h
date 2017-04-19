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
    kTransactionCategorySale,
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
    kTransactionTypeIncome   = 0,
    kTransactionTypeExpense  = 1,
    kTransactionTypeTransfer = 2
};

typedef NS_ENUM(NSInteger, UIPickerType)
{
    kUIPickerTypeDaily       = 0,
    kUIPickerTypeAfterNDays  = 1,
    kUIPickerTypeRepetitions = 2
};

typedef NS_ENUM(NSInteger, MenuItems)
{
    kMenuItemPlannedPayments = 0,
    kMenuItemExports,
    kMenuItemDebs,
    kMenuItemShoppingLists,
    kMenuItemWarranties,
    kMenuItemLocations,
    kMenuItemReminder,
    kMenuItemHelp,
    kMenuItemSettings,
    kMenuItemLogout
};

typedef NS_ENUM(NSInteger, SortOptions)
{
    kSortOptionShowAll = 0,
    kSortOptionShowToday,
    kSortOptionShowLastWeek,
    kSortOptionShowLastMonth,
    kSortOptionShowLastYear
};

typedef NS_ENUM(NSInteger, WarrantiesSortOptions)
{
    WarrantieSortOptionByCreationDateNewest = 0,
    WarrantieSortOptionByCreationDateOldest,
    WarrantieSortOptionByAmountHighest,
    WarrantieSortOptionByAmountLowest,
    WarrantieSortOptionByDueDateNewest,
    WarrantieSortOptionByDueDateOldest
};

typedef NS_ENUM(NSInteger, SortType){
    DateSort,
    TransactionTypeSort
};

typedef NS_ENUM(NSInteger, PlannedPaymentsSort)
{
    PlannedPaymentsSortByCreationDateNewest = 0,
    PlannedPaymentsSortByCreationDateOldest,
    PlannedPaymentsSortByNameAZ,
    PlannedPaymentsSortByNameZA,
    PlannedPaymentsSortByAmountAscending,
    PlannedPaymentsSortByAmountDescending
};

typedef NS_ENUM(NSInteger, PlannedInterval)
{
    PlannedIntervalRepeatDaily = 0,
    PlannedIntervalRepeatWeekly,
    PlannedIntervalRepeatMonthly,
    PlannedIntervalRepeatYearly
};

#endif /* Enums_h */
