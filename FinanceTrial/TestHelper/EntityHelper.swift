//
//  EntityHelper.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

class EntityHelper {
    private static func getRandomExpenseCategory() -> ExpenseCategory {
        return ExpenseCategory.allCases[Int.random(in: 0..<4)]
    }
    
    private static func getRandomIncomeCategory() -> IncomeCategory {
        return IncomeCategory.allCases[Int.random(in: 0..<1)]
    }
    
    private static func getRandomAmount(_ isPositiv: Bool = true) -> Double {
        let value = Double.random(in: 0..<100)
        if isPositiv {
            return value
        } else {
            return value * -1
        }
    }
    
    private static func shouldUseExpenseCategory() -> Bool {
        return Int.random(in: 0..<2) == 0
    }
    
    static func createUser(bookings: [Booking]) -> User {
        return User(bookings: bookings)
    }
    
    static func createBookings(accountTypes: [AccountType:Int]) -> [Booking] {
        var bookings: [Booking]  = []
        
        let numberOfBookingsForCashs = accountTypes[.cash] ?? 0
        let numberOfBookingsForCreditCard = accountTypes[.creditCard] ?? 0
        let numberOfBookingsForBankAccounts = accountTypes[.bankAccount] ?? 0
        
        for _ in (0..<numberOfBookingsForCashs) {
            if shouldUseExpenseCategory() {
                bookings.append(Booking(id: UUID(), account: .cash, expenseCategory: getRandomExpenseCategory(), amount: getRandomAmount(false) , date: Date.randomDate(range: 500)))
            } else {
                bookings.append(Booking(id: UUID(), account: .cash, incomeCategory: getRandomIncomeCategory(), amount: getRandomAmount() , date: Date.randomDate(range: 500)))
            }
        }
        
        for _ in (0..<numberOfBookingsForCreditCard) {
            if shouldUseExpenseCategory() {
                bookings.append(Booking(id: UUID(), account: .creditCard, expenseCategory: getRandomExpenseCategory(), amount: getRandomAmount(false), date: Date.randomDate(range: 500)))
            } else {
                bookings.append(Booking(id: UUID(), account: .creditCard, incomeCategory: getRandomIncomeCategory(), amount: getRandomAmount(), date: Date.randomDate(range: 500)))
            }
        }
        for _ in (0..<numberOfBookingsForBankAccounts) {
            if shouldUseExpenseCategory() {
                bookings.append(Booking(id: UUID(), account: .bankAccount, expenseCategory: getRandomExpenseCategory(), amount: getRandomAmount(false), date: Date.randomDate(range: 500)))
            } else {
                bookings.append(Booking(id: UUID(), account: .bankAccount, incomeCategory: getRandomIncomeCategory(), amount: getRandomAmount(), date: Date.randomDate(range: 500)))
            }
        }
        
        return bookings
    }
    
    
    static func createDefaultDummyData() {
        let accountTypes = [AccountType.bankAccount: 8, AccountType.cash: 12, AccountType.creditCard: 20]
        let bookings = createBookings(accountTypes: accountTypes)
        let user = createUser(bookings: [])
        
        let bookingPersistence = BookingPersistence()
        try? bookingPersistence.saveUser(user)
        
        let bookingRepository = BookingRepository(persistenceDelegate: BookingPersistence())
        let dashboardInteractor = BookingInteractor(bookingRepository: bookingRepository)
        
        for booking in bookings {
            try? dashboardInteractor.addBooking(booking)
        }
    }
}
