//
//  BookingInteractor.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

class BookingInteractor {
    private let bookingRepository: BookingDelegate

    init(bookingRepository: BookingDelegate) {
        self.bookingRepository = bookingRepository
    }

    // MARK: - publics
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
    
    func getSumOfAmount(for accountType: AccountType) -> Double {
        return getBookings(accountType: accountType).map { $0.amount}.reduce(0, +)
    }
    
    func addBooking(_ booking: Booking) throws  {
        let validatedBooking = validateBooking(booking)
        do {
            return try bookingRepository.add(booking: validatedBooking)
        } catch {
            throw error
        }
    }
    
    func editBooking(_ booking: Booking) throws  {
        let validatedBooking = validateBooking(booking)
        
        do {
            return try bookingRepository.edit(booking: validatedBooking)
        } catch {
            throw error
        }
    }
    
    // MARK: - privates
    /**
     - Ensures that amount always has only two decimal places and that the sign of amount is set correctly.
     - So invalid entries shouldn't  possible
     */
    private func validateBooking(_ booking: Booking) -> Booking {
        let checkedSignForAmountBooking = checkSignForAmount(for: booking)
        let roundUpAmountBooking = roundUpAmountDecimalPoints(for: checkedSignForAmountBooking)
        return roundUpAmountBooking
    }
    
    private func checkSignForAmount(for booking: Booking) -> Booking {
        var manipulatedBooking = booking
        if booking.expenseCategory != nil && booking.amount > 0 {
            manipulatedBooking.amount = booking.amount * -1
        }
        if booking.incomeCategory != nil && booking.amount < 0 {
            manipulatedBooking.amount = booking.amount * -1
        }
        
        return manipulatedBooking
    }
    
    private func roundUpAmountDecimalPoints(for booking: Booking) -> Booking {
        var manipulatedBooking = booking
        manipulatedBooking.amount = booking.amount.rounded(toPlaces: 2)
        return manipulatedBooking
    }
}
