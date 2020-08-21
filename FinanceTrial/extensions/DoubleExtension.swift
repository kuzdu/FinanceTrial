//
//  DoubleExtension.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 21.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

extension Double {
    
    // Copied from here https://stackoverflow.com/a/32581409/4420355 
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
