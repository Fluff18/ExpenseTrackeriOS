//
//  PreviewData.swift
//  ExpenseTracker
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "08/18/1999", institution: "Fluffy", account: "FinanceApp", merchant: "Apple", amount: 1808, type: "debit", categoryId: 108, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
