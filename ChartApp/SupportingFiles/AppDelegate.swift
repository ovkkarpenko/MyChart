//
//  AppDelegate.swift
//  ChartApp
//
//  Created by Oleksandr Karpenko on 10.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var rootVc = ChartViewController()
        
        window = UIWindow()
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()
        
        return true
    }
}

