//
//  User.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    var bookings: [Booking]
    
    init() {
        self.name = ""
        bookings = []
    }
    
    init(name: String, bookings: [Booking]) {
        self.name = name
        self.bookings = bookings
    }
    
    func filterBooking(for accountType: AccountType) -> [Booking] {
        return bookings.filter { $0.account == accountType }
    }
}
