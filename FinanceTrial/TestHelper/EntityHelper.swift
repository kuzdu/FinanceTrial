//
//  EntityHelper.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

class EntityHelper {
    static func createUser(bookings: [Booking]) -> User {
        return User(name: "Michael", bookings: bookings)
    }
    
    static func createBookings(accountTypes: [AccountType:Int]) -> [Booking] {
        var bookings: [Booking]  = []
        
        let numberOfBookingsForCashs = accountTypes[.cash] ?? 0
        let numberOfBookingsForCreditCard = accountTypes[.creditCard] ?? 0
        let numberOfBookingsForBankAccounts = accountTypes[.bankAccount] ?? 0
        
        for _ in (0..<numberOfBookingsForCashs) {
            bookings.append(Booking(id: UUID(), account: .cash, expenseCategory: .tax, amount: 10.0 , date: Date()))
        }
        
        for _ in (0..<numberOfBookingsForCreditCard) {
            bookings.append(Booking(id: UUID(), account: .creditCard, expenseCategory: .tax, amount: 10.0 , date: Date()))
        }
        for _ in (0..<numberOfBookingsForBankAccounts) {
            bookings.append(Booking(id: UUID(), account: .bankAccount, expenseCategory: .tax, amount: 10.0 , date: Date()))
        }
        
        return bookings
    }
}
