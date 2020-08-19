//
//  BookingInteractor.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

class DashboardInteractor {
    private let bookingRepository = BookingRepository()
    
    func getBookings(accountType: AccountType) {
        bookingRepository.getAccount(for: accountType)
    }
}
