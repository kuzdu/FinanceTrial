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
    func getAccount(for accountType: AccountType)
}

class BookingRepository: BookingDelegate {
    
    private let bookingPersistence = BookingPersistence()
    
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
    
    func delete(booking: Booking) throws {
        do {
            try bookingPersistence.deleteBooking(booking)
        } catch {
            throw error
        }
    }
    
    func getAccount(for accountType: AccountType) {
        
    }
}
