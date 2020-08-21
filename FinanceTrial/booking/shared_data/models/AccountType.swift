//
//  AccountType.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

enum AccountType: String, Codable, CaseIterable {
    case cash = "Cash"
    case creditCard = "Credit Card"
    case bankAccount = "Bank Account"
}

