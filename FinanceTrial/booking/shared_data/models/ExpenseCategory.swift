//
//  ExpenseCategory.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation


enum ExpenseCategory: String, Codable, CaseIterable {
    case tax = "Tax"
    case grocery = "Grocery"
    case entertainment = "Entertainment"
    case gym = "Gym"
    case health = "Health"
}
