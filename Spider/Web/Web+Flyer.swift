//
//  Web+Flyer.swift
//  Spider
//
//  Created by Andre Luiz Salla on 18/08/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit
import Flies

extension Web: Flyer {
    
    func flowFly(to viewController: UIViewController,
                 in window: WindowProtocol?,
                 with type: PresentationType) {
        if let rootViewController = window?.rootViewController {
            var topViewController = rootViewController
            while topViewController.presentedViewController != nil {
                topViewController = rootViewController.presentedViewController!
            }
            if type == .present {
                topViewController.present(viewController, animated: true, completion: nil)
            } else {
                if let navigation = topViewController as? UINavigationController {
                    navigation.pushViewController(viewController, animated: true)
                }
            }
        } else {
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }
    }
    
}
