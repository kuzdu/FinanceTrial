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
    
    override func setUpWithError() throws {
        UserDefaults.standard.removeObject(forKey: "userKey")
    }
    
    override func tearDownWithError() throws {
        
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
}
