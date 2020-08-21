//
//  BaseTextField.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 21.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation
import UIKit

class BaseTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func configureUI() {
        borderStyle = .none
        layer.masksToBounds = true
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
}
