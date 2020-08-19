//
//  BookingPersistenceTests.swift
//  FinanceTrialTests
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation
import XCTest
@testable import FinanceTrial

class BookingPersistenceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "userKey")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSavingUser() throws {
        // GIVEN a user with different bookings
        let accountTypes = [AccountType.bankAccount: 4, AccountType.cash: 6, AccountType.creditCard: 8]
        let bookings = EntityHelper.createBookings(accountTypes: accountTypes)
        let user = EntityHelper.createUser(bookings: bookings)
        
        // WHEN they are added, the should exist add the user
        let bookingPersistence = BookingPersistence()
        do {
            try bookingPersistence.saveUser(user)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        
        // THEN they should exist
        do {
            let loadedUser = try bookingPersistence.loadUser()
            XCTAssertEqual(18, loadedUser.bookings.count)
            XCTAssertEqual(4, loadedUser.filterBooking(for: .bankAccount).count)
            XCTAssertEqual(6, loadedUser.filterBooking(for: .cash).count)
            XCTAssertEqual(8, loadedUser.filterBooking(for: .creditCard).count)
            XCTAssertEqual("Michael", loadedUser.name)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAddBookingToUserWithBookings() throws {
        // GIVEN a user with some bookings
        let accountTypes = [AccountType.bankAccount: 1, AccountType.cash: 2, AccountType.creditCard: 0]
        let bookings = EntityHelper.createBookings(accountTypes: accountTypes)
        let user = EntityHelper.createUser(bookings: bookings)
        let bookingPersistence = BookingPersistence()
        try bookingPersistence.saveUser(user)
        
        // WHEN they are added, the should exist add the user
        do {
            let newBooking = Booking(account: .cash, expenseCategory: .entertainment, amount: 20.0, date: Date())
            try bookingPersistence.addBooking(newBooking)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        
        // THEN they should exist
        do {
            let loadedUser = try bookingPersistence.loadUser()
            XCTAssertEqual(4, loadedUser.bookings.count)
            XCTAssertEqual(1, loadedUser.filterBooking(for: .bankAccount).count)
            XCTAssertEqual(3, loadedUser.filterBooking(for: .cash).count)
            XCTAssertEqual(0, loadedUser.filterBooking(for: .creditCard).count)
            XCTAssertEqual("Michael", loadedUser.name)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    
    func testAddBookingToUserWithoutBookings() throws {
        // GIVEN is no user - it is the first start
        let bookingPersistence = BookingPersistence()
        
        // WHEN a new booking is added there should be a user
        do {
            let newBooking = Booking(account: .cash, expenseCategory: .entertainment, amount: 20.0, date: Date())
            try bookingPersistence.addBooking(newBooking)

            let newBooking2 = Booking(account: .cash, expenseCategory: .entertainment, amount: 20.0, date: Date())
            try bookingPersistence.addBooking(newBooking2)

            let newBooking3 = Booking(account: .creditCard, expenseCategory: .entertainment, amount: 20.0, date: Date())
            try bookingPersistence.addBooking(newBooking3)

        } catch {
            XCTFail(error.localizedDescription)
        }
        
        // THEN they should exist
        do {
            let loadedUser = try bookingPersistence.loadUser()
            XCTAssertEqual(3, loadedUser.bookings.count)
            XCTAssertEqual(0, loadedUser.filterBooking(for: .bankAccount).count)
            XCTAssertEqual(2, loadedUser.filterBooking(for: .cash).count)
            XCTAssertEqual(1, loadedUser.filterBooking(for: .creditCard).count)
            XCTAssertEqual("Michael", loadedUser.name)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
