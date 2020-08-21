//
//  BookingInteractor.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

class DashboardInteractor {
    private let bookingRepository = BookingRepository(persistenceDelegate: BookingPersistence())

    func getBookings(accountType: AccountType) -> [Booking] {
        do {
            return try bookingRepository.getBookings(for: accountType)
        } catch {
            print("Log - Cannot fetch bookings for accountType: \(accountType.rawValue)")
            return []
        }
    }
    
    func deleteBooking(booking: Booking) {
        do {
            try bookingRepository.delete(booking: booking)
        } catch {
            print("Log - Cannot delete booking : \(booking.id)")
        }
    }
}
