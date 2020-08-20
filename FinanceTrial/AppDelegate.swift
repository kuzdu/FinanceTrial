//
//  AppDelegate.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 17.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let bookingPersistence = BookingPersistence()
        try? bookingPersistence.saveUser(EntityHelper.createDefaultDummyData())
        
        let homeViewController = DashboardViewController()
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
        return true
    }
}

