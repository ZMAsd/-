//
//  AppDelegate.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let homeVC = ZMHomeViewController.init()
        let navigationC = ZMNavigationViewController.init(rootViewController: homeVC)
        window!.rootViewController = navigationC
        window!.makeKeyAndVisible()
        return true
    }
}

