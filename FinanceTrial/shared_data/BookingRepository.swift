//
//  BookingRepository.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

protocol BookingDelegate {
    func add(booking: Booking)
    func edit(booking: Booking)
    func delete(for index: Int)
    func getAccount(for accountType: AccountType)
}

class BookingRepository: BookingDelegate {
    func add(booking: Booking) {
       
    }
    
    func edit(booking: Booking) {
            
    }
    
    func delete(for index: Int) {
        
    }
    
    func getAccount(for accountType: AccountType) {
        
    }
}
