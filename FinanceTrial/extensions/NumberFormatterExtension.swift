//
//  NumberFormatter.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 20.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation


class CurrencyService {
    private static let formatter = NumberFormatter()
    
    static func toCurrency(amount: Double) -> String {
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }
}
