//
//  BindFlowTestFly.swift
//  BindTestFramework
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies
import UIKit

class BindFlowTestFly: FlyFlow {
    
    static var path: Path {"spiderTests/BindFlowTestFly"}
    
    static var dependencies: [DependencyType] { [] }
    
    static func newInstance() -> Self {
        guard let instance = BindFlowTestFly() as? Self else {
            fatalError()
        }
        return instance
    }
    
    func start(with parameters: BaseType?) throws -> UIViewController {
        return UIViewController()
    }
    
}

