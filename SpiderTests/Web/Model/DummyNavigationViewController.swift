//
//  DummyNavigationViewController.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

class DummyNavigationViewController: UINavigationController {
    
    var lastPushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        lastPushedViewController = viewController
    }
    
}
