//
//  FlowRegistrableTest.swift
//  FliesTests
//
//  Created by André Salla on 21/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies
import UIKit

class FlowRegistrableTest: FlyFlow {
    
    static var path: Path { "flyTests/flowTests" }
    
    static var dependencies: [DependencyType] = []
    
    var startCalled = false
    
    static func newInstance() -> Self {
        FlowRegistrableTest() as! Self
    }
    
    func start(with parameters: BaseType?) throws -> UIViewController {
        startCalled = true
        return UIViewController()
    }
    
}
