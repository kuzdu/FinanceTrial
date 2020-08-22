//
//  AddOrEditBooking.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 20.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class AddOrEditBookingViewController: BookingBaseViewController {
    public var booking: Booking?
    private var selectedAccount: AccountType?
    private var selectedIncomeCategory: IncomeCategory?
    private var selectedExpenseCategory: ExpenseCategory?
    
    // MARK: - UI
    private var incomeOrExpenseSegmentControl: UISegmentedControl!
    
    // picker views
    private var accountPickerView: UIPickerView!
    private var categoryPickerView: UIPickerView!
    
    // textfields
    private var accountTextField: UITextField!
    private var categoryTextField: UITextField!
    private var amountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func addConstraints() {
        incomeOrExpenseSegmentControl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        accountTextField.snp.makeConstraints { (make) in
            make.top.equalTo(incomeOrExpenseSegmentControl.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        categoryTextField.snp.makeConstraints { (make) in
            make.top.equalTo(accountTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        amountTextField.snp.makeConstraints { (make) in
            make.top.equalTo(categoryTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
    
    private func addViews() {
        view.addSubview(incomeOrExpenseSegmentControl)
        view.addSubview(accountTextField)
        view.addSubview(categoryTextField)
        view.addSubview(amountTextField)
    }
    
    private func initCategoryPickerView() {
        categoryPickerView = UIPickerView()
        categoryPickerView.tag = 2
        categoryPickerView.delegate = self
    }
    
    private func initAccountTextField() {
        accountTextField = BaseTextField()
        accountTextField.inputView = accountPickerView
        accountTextField.placeholder = R.string.localizable.add_or_edit_account_placeholder()
    }
    
    private func initAccountPickerView() {
        accountPickerView = UIPickerView()
        accountPickerView.tag = 1
        accountPickerView.delegate = self
    }
    
    private func initCategoryTextField() {
        categoryTextField = BaseTextField()
        categoryTextField.inputView = categoryPickerView
        categoryTextField.placeholder = R.string.localizable.add_or_edit_category_placeholder()
    }
    
    private func initAmountTextField() {
        amountTextField = BaseTextField()
        amountTextField.textColor = UIColor.green
        amountTextField.keyboardType = .decimalPad
        amountTextField.placeholder = R.string.localizable.add_or_edit_amount_placeholder()
    }
    
    private func initIncomeOrExpenseSegmentControl() {
        incomeOrExpenseSegmentControl = UISegmentedControl(items: [R.string.localizable.add_or_edit_segment_income_title(),
                                                                   R.string.localizable.add_or_edit_segment_expence_title()])
        incomeOrExpenseSegmentControl.selectedSegmentIndex = 0
        incomeOrExpenseSegmentControl.addTarget(self, action: #selector(segmentedControlValueChanged), for:.valueChanged)
    }
    
    private func isExpenseSegmentControl() -> Bool {
        return incomeOrExpenseSegmentControl.selectedSegmentIndex == 1
    }
    
    private func setData(for booking: Booking) {
        amountTextField.text = "\(booking.amount)"
        accountTextField.text = booking.account.rawValue
        selectedAccount = booking.account
        
        if let expenseCategory = booking.expenseCategory {
            incomeOrExpenseSegmentControl.selectedSegmentIndex = 1
            let index = ExpenseCategory.allCases.firstIndex(of: expenseCategory) ?? 0
            updateSelectedCategory(index: index)
        } else if let incomeCategory = booking.incomeCategory {
            incomeOrExpenseSegmentControl.selectedSegmentIndex = 0
            let index = IncomeCategory.allCases.firstIndex(of: incomeCategory) ?? 0
            updateSelectedCategory(index: index)
        }
    }
    
    private func initUI() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        initIncomeOrExpenseSegmentControl()
        
        initAccountPickerView()
        initAccountTextField()
        
        initCategoryPickerView()
        initCategoryTextField()
        
        initAmountTextField()

        addViews()
        addConstraints()
        
        addNavigationBarButton()

        if isEditingBooking() {
            guard let booking = booking else {
                return
            }
            setData(for: booking)
        }
    }
    
    private func addNavigationBarButton() {
        let addOrEditBookingTitle = isEditingBooking() ? R.string.localizable.add_or_edit_account_update_action() : R.string.localizable.add_or_edit_account_add_action()
        let addOrEditBookingBarButtonItem = UIBarButtonItem(title: addOrEditBookingTitle, style: .done, target: self, action: #selector(addOrEditBooking))
        self.navigationItem.rightBarButtonItem  = addOrEditBookingBarButtonItem
    }
    
    private func isEditingBooking() -> Bool {
        return booking != nil
    }
    
    private func isCategoryPickerView(_ pickerView: UIPickerView) -> Bool {
        return pickerView.tag == 2
    }
    
    private func updateSelectedCategory(index: Int) {
        if isExpenseSegmentControl() {
            selectedIncomeCategory = nil
            selectedExpenseCategory = ExpenseCategory.allCases[index]
            categoryTextField.text = ExpenseCategory.allCases[index].rawValue
            amountTextField.textColor = UIColor.red
        } else {
            selectedExpenseCategory = nil
            selectedIncomeCategory = IncomeCategory.allCases[index]
            categoryTextField.text = IncomeCategory.allCases[index].rawValue
            amountTextField.textColor = UIColor.green
        }
    }
    
    @objc func segmentedControlValueChanged(segment: UISegmentedControl) {
        categoryPickerView.reloadAllComponents()
        updateSelectedCategory(index: 0)
    }

    @objc func addOrEditBooking() {
        guard let selectedAccount = selectedAccount else {
            Alerts.showTextAlert(viewController: self, title: R.string.localizable.error_missing_data_title(), message: R.string.localizable.no_account_selected_error())
            return
        }
        
        if (selectedIncomeCategory == nil && selectedExpenseCategory == nil) {
            Alerts.showTextAlert(viewController: self, title:  R.string.localizable.error_missing_data_title(), message: R.string.localizable.no_category_selected_error())
            return
        }
        
        guard let amount = amountTextField.text, !amount.isEmpty, let amountToDouble = Double(amount) else  {
            Alerts.showTextAlert(viewController: self, title:  R.string.localizable.error_missing_data_title(), message: R.string.localizable.no_amount_selected_error())
            return
        }
        
        if isEditingBooking() {
            booking?.account = selectedAccount
            booking?.amount = amountToDouble
            booking?.date = Date()
            
            if let incomeCategory = selectedIncomeCategory {
                booking?.expenseCategory = nil
                booking?.incomeCategory = incomeCategory
            } else if let expenseCategory = selectedExpenseCategory {
                booking?.incomeCategory = nil
                booking?.expenseCategory = expenseCategory
            }
            
            guard let updatedBooking = booking else {
                Logger.log(message: "Passend booking not found")
                return
            }
            
            do {
                try dashboardInteractor.editBooking(updatedBooking)
                self.navigationController?.popViewController(animated: true)
            } catch {
                Logger.log(message: "\(error.localizedDescription)")
            }
        } else {
            var newBooking = Booking(id: UUID(), account: selectedAccount, amount: amountToDouble, date: Date())
            
            if let expenseCategory = selectedExpenseCategory {
                newBooking.incomeCategory = nil
                newBooking.expenseCategory = expenseCategory
            } else if let incomeCategory = selectedIncomeCategory {
                newBooking.expenseCategory = nil
                newBooking.incomeCategory = incomeCategory
            } else {
                Logger.log(message: "Invalid state - parsing to income or expense category failed")
            }
            
            do {
                try dashboardInteractor.addBooking(newBooking)
                self.navigationController?.popViewController(animated: true)
            }  catch {
                Logger.log(message: "\(error.localizedDescription)")
            }
        }
    }
}

extension AddOrEditBookingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isCategoryPickerView(pickerView) {
            if isExpenseSegmentControl() {
                return ExpenseCategory.allCases[row].rawValue
            } else {
                return IncomeCategory.allCases[row].rawValue
            }
        } else {
            return AccountType.allCases[row].rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isCategoryPickerView(pickerView) {
            if isExpenseSegmentControl() {
                return ExpenseCategory.allCases.count
            } else {
                return IncomeCategory.allCases.count
            }
        }
        return AccountType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isCategoryPickerView(pickerView) {
            updateSelectedCategory(index: row)
        } else {
            selectedAccount = AccountType.allCases[row]
            accountTextField.text = AccountType.allCases[row].rawValue
        }
    }
}
