//
//  DummyViewController.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

class DummyViewController: UIViewController {
    
    var internalPresentedViewController: UIViewController?
    
    override var presentedViewController: UIViewController? {
        get {
            return internalPresentedViewController
        }
        set {
            internalPresentedViewController = newValue
        }
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedViewController = viewControllerToPresent
    }
    
}
