//
//  BookingRepository.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

protocol BookingDelegate {
    func add(booking: Booking) throws
    func edit(booking: Booking) throws
    func delete(booking: Booking) throws
    func getBookings(for accountType: AccountType) throws -> [Booking]
}

class BookingRepository: BookingDelegate {
    private let bookingPersistence: PersistenceDelegate

    init(persistenceDelegate: PersistenceDelegate) {
        self.bookingPersistence = persistenceDelegate
    }
    
    func add(booking: Booking) throws {
        do {
            try bookingPersistence.addBooking(booking)
        } catch {
            throw error
        }
    }
    
    func edit(booking: Booking) throws {
        do {
            try bookingPersistence.updateBooking(booking)
        } catch {
            throw error
        }
    }
    
    //TODO: Test schreiben
    func delete(booking: Booking) throws {
        do {
            try bookingPersistence.deleteBooking(booking)
        } catch {
            throw error
        }
    }
    
    //TODO: test schreiben
    func getBookings(for accountType: AccountType) throws -> [Booking] {
        do {
            let user = try bookingPersistence.loadUser()
            
            let limitedBookings = user.filterBooking(for: accountType).sorted {
                $0.date > $1.date
            }.prefix(10)
            
            return Array(limitedBookings)
        } catch {
            throw error
        }
    }
}
