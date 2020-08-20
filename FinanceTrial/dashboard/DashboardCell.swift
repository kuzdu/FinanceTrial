//
//  DashboardCell.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 20.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation
import SnapKit


class DashboardCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        
        self.contentView.addSubview(bookingTitleLabel)
        self.contentView.addSubview(bookingSubtitleLabel)
        self.contentView.addSubview(bookingAmountLabel)
        
        bookingTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        bookingSubtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bookingTitleLabel.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        bookingAmountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
    }

    var bookingTitleLabel : UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(17)
        label.textAlignment = .left
        label.text = "1"
        label.textColor = .black
        return label
    }()
    
    var bookingSubtitleLabel : UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(15)
        label.textAlignment = .left
        label.text = "1"
        label.textColor = .black
        label.alpha = 0.5
        return label
    }()
    
    private let bookingAmountLabel : UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(17)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    var amount: Double? {
        didSet {
            let unwrappedAmount  = amount ?? 0.0
            if unwrappedAmount < 0.0 {
                bookingAmountLabel.textColor = .red
            } else {
                bookingAmountLabel.textColor = .green
            }
            bookingAmountLabel.text =  CurrencyService.toCurrency(amount: unwrappedAmount)
        }
    }
}
