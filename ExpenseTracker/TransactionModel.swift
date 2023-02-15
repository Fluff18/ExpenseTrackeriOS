//
//  TransactionModel.swift
//  ExpenseTracker
//

import Foundation

import SwiftUIFontIcon
import SwiftUI

struct Transaction: Identifiable, Decodable, Hashable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var icon: FontAwesomeCode{
        if let category = Category.all.first(where: {$0.id == categoryId }) {
            return category.icon
        }
        
        return .question_circle
    }
    
    var dateParsed: Date {
        date.dateParser()
    }
    
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
}

enum TransactionType: String {
    case debit = "debit"
    case credit = "credit"
}

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryId: Int?
}

extension Category {
    static let autoAndTransport = Category(id: 1, name: "Auto & Transport", icon: .car_alt)
    static let billsAndUtilities = Category(id: 2, name: "Auto & Transport", icon: .file_invoice_dollar)
    static let entertainment = Category(id: 3, name: "Auto & Transport", icon: .film)
    static let feesAndCharges = Category(id: 4, name: "Auto & Transport", icon: .hand_holding_usd)
    static let foodAndDining = Category(id: 5, name: "Auto & Transport", icon: .hamburger)
    static let home = Category(id: 6, name: "Auto & Transport", icon: .home)
    static let income = Category(id: 7, name: "Auto & Transport", icon: .dollar_sign)
    static let shopping = Category(id: 8, name: "Auto & Transport", icon: .shopping_cart)
    static let transfer = Category(id: 9, name: "Auto & Transport", icon: .exchange_alt)
    
    static let publicTransporrt = Category(id: 101, name: "Auto & Transport", icon: .bus, mainCategoryId: 1)
    static let taxi = Category(id: 102, name: "Auto & Transport", icon: .taxi, mainCategoryId: 1)
    static let mobilePhone = Category(id: 201, name: "Auto & Transport", icon: .mobile_alt, mainCategoryId: 2)
    static let moviesAndDVDs = Category(id: 301, name: "Auto & Transport", icon: .film, mainCategoryId: 3)
    static let bankFee = Category(id: 401, name: "Auto & Transport", icon: .hand_holding_usd, mainCategoryId: 4)
    static let financeCharge = Category(id: 402, name: "Auto & Transport", icon: .hand_holding_usd, mainCategoryId: 4)
    static let groceries = Category(id: 501, name: "Auto & Transport", icon: .shopping_basket, mainCategoryId: 5)
    static let resturants = Category(id: 502, name: "Auto & Transport", icon: .utensils, mainCategoryId: 5)
    static let rent = Category(id: 601, name: "Auto & Transport", icon: .house_user, mainCategoryId: 6)
    static let homeSupplies = Category(id: 602, name: "Auto & Transport", icon: .lightbulb, mainCategoryId: 6)
    static let payCheque = Category(id: 701, name: "Auto & Transport", icon: .dollar_sign, mainCategoryId: 7)
    static let software = Category(id: 801, name: "Auto & Transport", icon: .icons, mainCategoryId: 8)
    static let creditCardPayment = Category(id: 901, name: "Auto & Transport", icon: .exchange_alt, mainCategoryId: 9)
}


extension Category
{
    static let categories: [Category] = [
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
        .feesAndCharges,
        .foodAndDining,
        .home,
        .income,
        .shopping,
        .transfer
    ]
    
    static let subCategories: [Category] = [
        .publicTransporrt,
        .taxi,
        .mobilePhone,
        .moviesAndDVDs,
        .bankFee,
        .financeCharge,
        .groceries,
        .resturants,
        .rent,
        .homeSupplies,
        .payCheque,
        .software,
        .creditCardPayment
    ]
    static let all: [Category] = categories + subCategories
    
}
