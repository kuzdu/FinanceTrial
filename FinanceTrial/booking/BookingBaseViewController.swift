//
//  BookingBaseViewController.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 21.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation
import UIKit

class BookingBaseViewController: UIViewController {
    let dashboardInteractor: BookingInteractor = {
        let bookingRepository = BookingRepository(persistenceDelegate: BookingPersistence())
        return BookingInteractor(bookingRepository: bookingRepository)
    }()
}
