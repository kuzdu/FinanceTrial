//
//  BookingInteractorTests.swift
//  FinanceTrialTests
//
//  Created by Michael Rothkegel on 22.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation
import XCTest
@testable import FinanceTrial


class BookingInteractorTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddBookingWithWrongsSigns() {
        // GIVEN is a dummy repostiry which hold the current booking in a variable
        let testBookingRepository = TestBookingRepository()
        let bookingInteractor = BookingInteractor(bookingRepository: testBookingRepository)
        
        // WHEN booking interactors is filled with wrong data, THEN the interactor should fix this
        
        // amount is positive but it is an expense category
        let bookingPositiveAmountExpenseCategory = Booking(id: UUID(), account: .cash, expenseCategory: .entertainment, amount: 20.0, date: Date())
        try? bookingInteractor.addBooking(bookingPositiveAmountExpenseCategory)
        XCTAssertEqual(-20.0, testBookingRepository.currentBooking?.amount)

        try? bookingInteractor.editBooking(bookingPositiveAmountExpenseCategory)
        XCTAssertEqual(-20.0, testBookingRepository.currentBooking?.amount)

        // amount is negative and it is expense category
        let bookingNegativeAmountExpenseCategory = Booking(id: UUID(), account: .cash, expenseCategory: .entertainment, amount: -20.0, date: Date())
        try? bookingInteractor.addBooking(bookingNegativeAmountExpenseCategory)
        XCTAssertEqual(-20.0, testBookingRepository.currentBooking?.amount)

        try? bookingInteractor.editBooking(bookingNegativeAmountExpenseCategory)
        XCTAssertEqual(-20.0, testBookingRepository.currentBooking?.amount)

        // amount is positive and it is incomeCategory category
        let bookingPositiveAmountIncomeCategory = Booking(id: UUID(), account: .cash, incomeCategory: .salary, amount: 20.0, date: Date())
        try? bookingInteractor.addBooking(bookingPositiveAmountIncomeCategory)
        XCTAssertEqual(20.0, testBookingRepository.currentBooking?.amount)

        try? bookingInteractor.editBooking(bookingPositiveAmountIncomeCategory)
        XCTAssertEqual(20.0, testBookingRepository.currentBooking?.amount)

        // amount is positive and it is incomeCategory category
        let bookingNegativeAmountIncomeCategory = Booking(id: UUID(), account: .cash, incomeCategory: .salary, amount: -20.0, date: Date())
        try? bookingInteractor.addBooking(bookingNegativeAmountIncomeCategory)
        XCTAssertEqual(20.0, testBookingRepository.currentBooking?.amount)

        try? bookingInteractor.editBooking(bookingNegativeAmountIncomeCategory)
        XCTAssertEqual(20.0, testBookingRepository.currentBooking?.amount)
    }
    
    
    class TestBookingRepository: BookingDelegate {
        var currentBooking: Booking?
        
        func add(booking: Booking) throws {
            currentBooking = booking
        }
        
        func edit(booking: Booking) throws {
            currentBooking = booking
        }
        
        func delete(booking: Booking) throws {
            // not needed
        }
        
        func getBookings(for accountType: AccountType) throws -> [Booking] {
            if let currentBooking = currentBooking {
                return [currentBooking]
            }
            return []
        }
    }
}
