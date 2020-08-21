//
//  AddOrEditBookingInteractor.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 20.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

class AddOrEditBookingInteractor {
    private let bookingRepository = BookingRepository(persistenceDelegate: BookingPersistence())

    func addBooking(_ booking: Booking) throws  {
        do {
            return try bookingRepository.add(booking: booking)
        } catch {
            throw error
        }
    }
    
    func editBooking(_ booking: Booking) throws  {
          do {
            return try bookingRepository.edit(booking: booking)
          } catch {
              throw error
          }
      }
}
