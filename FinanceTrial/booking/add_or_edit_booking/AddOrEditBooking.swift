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

class AddOrEditBooking: BookingBaseViewController {
    public var booking: Booking?
    private var selectedAccount: AccountType = .bankAccount
    private var selectedCategory: Categories = .dividends
    
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
    
    fileprivate func addConstraints() {
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
    
    fileprivate func addViews() {
        self.view.addSubview(incomeOrExpenseSegmentControl)
        self.view.addSubview(accountTextField)
        self.view.addSubview(categoryTextField)
        self.view.addSubview(amountTextField)
    }
    
    fileprivate func initCategoryPickerView() {
        categoryPickerView = UIPickerView()
        categoryPickerView.tag = 2
        categoryPickerView.delegate = self
    }
    
    fileprivate func initAccountTextField() {
        accountTextField = BaseTextField()
        accountTextField.inputView = accountPickerView
        accountTextField.placeholder = R.string.localizable.add_or_edit_account_placeholder()
    }
    
    fileprivate func initAccountPickerView() {
        accountPickerView = UIPickerView()
        accountPickerView.tag = 1
        accountPickerView.delegate = self
    }
    
    fileprivate func initCategoryTextField() {
        categoryTextField = BaseTextField()
        categoryTextField.inputView = categoryPickerView
        categoryTextField.placeholder = R.string.localizable.add_or_edit_category_placeholder()
    }
    
    fileprivate func initAmountTextField() {
        amountTextField = BaseTextField()
        amountTextField.keyboardType = .decimalPad
        amountTextField.placeholder = R.string.localizable.add_or_edit_amount_placeholder()
    }
    
    fileprivate func initIncomeOrExpenseSegmentControl() {
        incomeOrExpenseSegmentControl = UISegmentedControl(items: [R.string.localizable.add_or_edit_segment_income_title(),
                                                                   R.string.localizable.add_or_edit_segment_expence_title()])
        incomeOrExpenseSegmentControl.selectedSegmentIndex = 0
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
        
        let addOrEditBookingTitle = isEditingBooking() ? "Update Booking" : "Add Booking"
        let addOrEditBookingBarButtonItem = UIBarButtonItem(title: addOrEditBookingTitle, style: .done, target: self, action: #selector(addOrEditBooking))
        self.navigationItem.rightBarButtonItem  = addOrEditBookingBarButtonItem
        
        if isEditingBooking() {
            guard let booking = booking else {
                return
            }
            
            amountTextField.text =  "x"
            accountTextField.text = booking.account.rawValue
            
            if let expenseCategory = booking.expenseCategory {
                categoryTextField.text = expenseCategory.rawValue
            } else if let incomeCategory = booking.incomeCategory {
                categoryTextField.text = incomeCategory.rawValue
            }
            
            let index = AccountType.allCases.firstIndex(of: booking.account) ?? 0
            incomeOrExpenseSegmentControl.selectedSegmentIndex = index
        }
    }
    
    private func isEditingBooking() -> Bool {
        return booking != nil
    }
    
    @objc func addOrEditBooking() {
        let amount = Double(amountTextField.text ?? "") ?? 0.0
        
        if isEditingBooking() {
            booking?.account = selectedAccount
            booking?.amount = amount
            booking?.date = Date()
            
            if let incomeCategory = selectedCategory.toIncomeCategory() {
                booking?.incomeCategory = incomeCategory
            } else if let expenseCategory = selectedCategory.toExpenseCategory() {
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
            var newBooking = Booking(id: UUID(), account: selectedAccount, amount: amount, date: Date())
            
            if let expenseCategory = selectedCategory.toExpenseCategory() {
                newBooking.expenseCategory = expenseCategory
            } else if let incomeCategory = selectedCategory.toIncomeCategory() {
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
    
    private func isCategoryPickerView(_ pickerView: UIPickerView) -> Bool {
        return pickerView.tag == 2
    }
}

extension AddOrEditBooking: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isCategoryPickerView(pickerView) {
            return Categories.allCases[row].rawValue
        } else {
            return AccountType.allCases[row].rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isCategoryPickerView(pickerView) {
            return Categories.allCases.count
        }
        return AccountType.allCases.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isCategoryPickerView(pickerView) {
            selectedCategory = Categories.allCases[row]
            categoryTextField.text = Categories.allCases[row].rawValue
        } else {
            selectedAccount = AccountType.allCases[row]
            accountTextField.text = AccountType.allCases[row].rawValue
        }
    }
}

/*let categoryItems = [R.string.localizable.expense_category_tax(),
 R.string.localizable.expense_category_grocery(),
 R.string.localizable.expense_category_entertainment(),
 R.string.localizable.expense_category_gym(),
 R.string.localizable.expense_category_health(),
 R.string.localizable.income_category_salary(),
 R.string.localizable.income_category_dividends()]*/
// R.string.localizable.add_or_edit_segment_cash(), R.string.localizable.add_or_edit_segment_credit_card(), R.string.localizable.add_or_edit_segment_bank_account()
