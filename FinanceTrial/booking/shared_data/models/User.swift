//
//  User.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

struct User: Codable {
    var bookings: [Booking]
    
    init() {
        bookings = []
    }
    
    init(bookings: [Booking]) {
        self.bookings = bookings
    }
    
    func filterBooking(for accountType: AccountType) -> [Booking] {
        return bookings.filter { $0.account == accountType }
    }
}
