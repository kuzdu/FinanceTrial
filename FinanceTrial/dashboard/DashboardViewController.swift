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
    
    private var cashBookings: [Booking] = []
    private var creditCardBookings: [Booking] = []
    private var bankAccountBookings: [Booking] = []
    
    private var dashboardTableView: UITableView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillTableView()
    }
    
    private func addAddButtonToNavigationBar() {
        let addBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addOrEditBooking))
        self.navigationItem.rightBarButtonItem  = addBarButtonItem
    }
    
    private func initTableView() {
        dashboardTableView = UITableView()
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
    
    private func setNavigationTitle() {
        self.title = R.string.localizable.dashboard_title()
    }
    
    private func initUI() {
        setNavigationTitle()
        initTableView()
        addAddButtonToNavigationBar()
        fillTableView()
    }
    
    private func fillTableView() {
        cashBookings = dashboardInteractor.getBookings(accountType: .cash)
        creditCardBookings = dashboardInteractor.getBookings(accountType: .creditCard)
        bankAccountBookings = dashboardInteractor.getBookings(accountType: .bankAccount)
        dashboardTableView?.reloadData()
    }
    
    private func setBooking(_ booking: Booking, for dashboardCell: DashboardCell) {
        dashboardCell.amount = booking.amount
        dashboardCell.bookingTitleLabel.text = booking.incomeCategory?.rawValue ?? booking.expenseCategory?.rawValue
        dashboardCell.bookingSubtitleLabel.text = booking.date.toString()
    }
    
    @objc func addOrEditBooking() {
        goToAddOrEditBooking(with: nil)
    }
    
    func goToAddOrEditBooking(with booking: Booking?) {
        let addOrEditBooking = AddOrEditBooking()
        addOrEditBooking.booking = booking
        self.navigationController?.pushViewController(addOrEditBooking, animated: true)
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
            let cashBooking = cashBookings[indexPath.row]
            setBooking(cashBooking, for: dashboardCell)
        case .creditCard:
            let creditCardBooking = creditCardBookings[indexPath.row]
            setBooking(creditCardBooking, for: dashboardCell)
        case .bankAccount:
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
            return cashBookings.count
        case .creditCard:
            return creditCardBookings.count
        case .bankAccount:
            return bankAccountBookings.count
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dashboardSectionType = dashboardSectionTypes[indexPath.section]
        
        switch dashboardSectionType {
        case .cash:
            let booking = cashBookings[indexPath.row]
            goToAddOrEditBooking(with: booking)
        case .creditCard:
            let booking = creditCardBookings[indexPath.row]
            goToAddOrEditBooking(with: booking)
        case .bankAccount:
            let booking = bankAccountBookings[indexPath.row]
            goToAddOrEditBooking(with: booking)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var booking: Booking!
            
            let dashboardSectionType = dashboardSectionTypes[indexPath.section]
            switch dashboardSectionType {
            case .cash:
                booking = cashBookings[indexPath.row]
                cashBookings.remove(at: indexPath.row)
            case .creditCard:
                booking = creditCardBookings[indexPath.row]
                creditCardBookings.remove(at: indexPath.row)
            case .bankAccount:
                booking = bankAccountBookings[indexPath.row]
                bankAccountBookings.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            dashboardInteractor.deleteBooking(booking: booking)
        }
    }
}
