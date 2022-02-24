//
//  DummyWindowModel.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit
@testable import Spider

class DummyWindowModel: WindowProtocol {
    var isKeyWindow: Bool = false
    
    var rootViewController: UIViewController?
    
    func makeKeyAndVisible() {
        isKeyWindow = true
    }
    
}
