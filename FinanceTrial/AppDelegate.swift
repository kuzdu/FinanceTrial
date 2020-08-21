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
        
      
        UserDefaults.standard.removeObject(forKey: "userKey")
        //EntityHelper.createDefaultDummyData()
        
        let navigationViewController = UINavigationController()
        let homeViewController = DashboardViewController()
        navigationViewController.viewControllers = [homeViewController]
        
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        return true
    }
}

