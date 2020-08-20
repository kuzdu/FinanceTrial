//
//  DashboardViewController.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 17.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation
import UIKit

enum DashboardSectionType {
    case cash
    case creditCard
    case bankAccount
}

class DashboardViewController: UIViewController {
    private let dashboardSectionTypes: [DashboardSectionType] = [.cash, .bankAccount, .creditCard]
    private let dashboardInteractor = DashboardInteractor()
    private let dashboardCellId = "DashboardCellIdent"
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let dashboardTableView = UITableView()
        view.addSubview(dashboardTableView)
        
        dashboardTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        dashboardTableView.delegate = self
        dashboardTableView.dataSource = self
        dashboardTableView.register(DashboardCell.self, forCellReuseIdentifier: dashboardCellId)
        dashboardTableView.estimatedRowHeight = 40
        dashboardTableView.tableFooterView = UIView()
        dashboardTableView.reloadData()
        
    }
    
    private func setBooking(_ booking: Booking, for dashboardCell: DashboardCell) {
        dashboardCell.amount = booking.amount
        dashboardCell.bookingTitleLabel.text = booking.incomeCategory?.rawValue ?? booking.expenseCategory?.rawValue
        dashboardCell.bookingSubtitleLabel.text = booking.date.toString()
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dashboardSectionType = dashboardSectionTypes[indexPath.section]
        
        guard let dashboardCell = tableView.dequeueReusableCell(withIdentifier: dashboardCellId, for: indexPath) as? DashboardCell else {
            return UITableViewCell()
        }
        
        switch dashboardSectionType {
        case .cash:
            let cashBookings = dashboardInteractor.getBookings(accountType: .cash)
            let cashBooking = cashBookings[indexPath.row]
            setBooking(cashBooking, for: dashboardCell)
        case .creditCard:
            let creditCardBookings = dashboardInteractor.getBookings(accountType: .creditCard)
            let creditCardBooking = creditCardBookings[indexPath.row]
            setBooking(creditCardBooking, for: dashboardCell)
        case .bankAccount:
            let bankAccountBookings = dashboardInteractor.getBookings(accountType: .bankAccount)
            let bankAccountBooking = bankAccountBookings[indexPath.row]
            setBooking(bankAccountBooking, for: dashboardCell)
        }
        return dashboardCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dashboardSectionTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dashboardSectionType = dashboardSectionTypes[section]
        
        switch dashboardSectionType {
        case .cash:
            return dashboardInteractor.getBookings(accountType: .cash).count
        case .creditCard:
            return dashboardInteractor.getBookings(accountType: .creditCard).count
        case .bankAccount:
            return dashboardInteractor.getBookings(accountType: .bankAccount).count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dashboardSectionType = dashboardSectionTypes[section]
        
        switch dashboardSectionType {
        case .cash:
            return R.string.localizable.dashboard_section_title_cash()
        case .creditCard:
            return R.string.localizable.dashboard_section_title_credit_card()
        case .bankAccount:
            return R.string.localizable.dashboard_section_title_bank_account()
        }
    }
}


/*
 - swipe to delete bauen
 - navigation viewcontroller plus item bauen
 */
