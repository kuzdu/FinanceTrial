//
//  Booking.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

struct Booking: Codable {
    var id: UUID
    var account: AccountType
    var expenseCategory: ExpenseCategory? = nil 
    var incomeCategory: IncomeCategory? = nil
    var date: Date
    var amount: Double
    
    
    init(id: UUID, account: AccountType, amount: Double, date: Date) {
        self.id = id
        self.account = account
        self.amount = amount
        self.date = date
    }
    
    init(id: UUID, account: AccountType, expenseCategory: ExpenseCategory, amount: Double, date: Date) {
        self.id = id
        self.account = account
        self.expenseCategory = expenseCategory
        self.amount = amount
        self.date = date
    }
    
    init(id: UUID, account: AccountType, incomeCategory: IncomeCategory, amount: Double, date: Date) {
        self.id = id
        self.account = account
        self.incomeCategory = incomeCategory
        self.amount = amount
        self.date = date
    }
}
