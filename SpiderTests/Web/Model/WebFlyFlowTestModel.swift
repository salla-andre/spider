//
//  WebFlyFlowTestModel.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies
import UIKit

class WebFlyFlowTestModel: FlyFlow {
    static var path: Path { "spiderTests/WebFlyFlowTestModel" }
    
    static var dependencies: [DependencyType] = []
    
    var startIsCalled = false
    
    static func newInstance() -> Self {
        guard let instance = WebFlyFlowTestModel() as? Self else {
            fatalError()
        }
        return instance
    }
    
    func start(with parameters: Parameter?) throws -> UIViewController {
        startIsCalled = true
        return UIViewController()
    }
}
