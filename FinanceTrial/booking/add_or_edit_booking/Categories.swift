//
//  Categories.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 21.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

enum Categories: String, CaseIterable {
    case tax = "Tax"
    case grocery = "Grocery"
    case entertainment = "Entertainment"
    case gym = "Gym"
    case health = "Health"
    case salary = "Salary"
    case dividends = "Dividens"
    
    func toIncomeCategory() -> IncomeCategory? {
        if self == Categories.salary {
            return IncomeCategory.salary
        } else if self == Categories.dividends {
            return IncomeCategory.dividends
        }
        return nil
    }
    
    func toExpenseCategory() -> ExpenseCategory? {
        switch self {
        case .tax:
            return ExpenseCategory.tax
        case .grocery:
            return ExpenseCategory.grocery
        case .entertainment:
            return ExpenseCategory.entertainment
        case .gym:
            return ExpenseCategory.gym
        case .health:
            return ExpenseCategory.health
        case .salary, .dividends:
            return nil
        }
    }
}
