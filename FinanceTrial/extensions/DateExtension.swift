//
//  DateExtension.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 20.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateformat = DateFormatter()
        dateformat.dateStyle = .medium
        dateformat.timeStyle = .short
        return dateformat.string(from: self)
    }
    
    // Coppied from here: https://stackoverflow.com/a/52023150/4420355
    // it is used to create random date dummy data
    static func randomDate(range: Int) -> Date {
        // Get the interval for the current date
        let interval =  Date().timeIntervalSince1970
        // There are 86,400 milliseconds in a day (ignoring leap dates)
        // Multiply the 86,400 milliseconds against the valid range of days
        let intervalRange = Double(86_400 * range)
        // Select a random point within the interval range
        let random = Double(arc4random_uniform(UInt32(intervalRange)) + 1)
        // Since this can either be in the past or future, we shift the range
        // so that the halfway point is the present
        let newInterval = interval + (random - (intervalRange / 0.5))
        // Initialize a date value with our newly created interval
        return Date(timeIntervalSince1970: newInterval)
    }
}


