//
//  Alerter.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 21.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation
import UIKit

class Alerts {
    static func showTextAlert(viewController: UIViewController, title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: R.string.localizable.general_ok(), style: .default, handler: { (action) in
            completion?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
