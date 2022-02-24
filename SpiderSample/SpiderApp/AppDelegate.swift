//
//  AppDelegate.swift
//  SpiderPoc
//
//  Created by Andre Luiz Salla on 10/07/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import UIKit
import Spider
import FirstFramework
import SecondFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKey()
        
        do {
            try SpiderMain.bind()
            try SpiderMain.vibration.flow(signal: "initial")
        } catch {
            fatalError(error.localizedDescription)
        }
        
        return true
    }

}

