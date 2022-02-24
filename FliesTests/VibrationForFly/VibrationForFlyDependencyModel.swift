//
//  VibrationForFlyDependencyModel.swift
//  FliesTests
//
//  Created by André Salla on 20/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies
import UIKit

class VibrationForFlyDependencyFlowModel: FlyFlow {
    
    static var path: Path = "fliesTests/VibrationForFlyDependencyFlowModel"
    
    static var dependencies: [DependencyType] =
        [.required("flyTests/serviceTests"),
         .optional("flyTests/flowTests")]
    
    var startCalled = false
    
    static func newInstance() -> Self {
        return VibrationForFlyDependencyFlowModel() as! Self
    }
    
    func start(with parameters: BaseType?) throws -> UIViewController {
        startCalled = true
        return UIViewController()
    }
    
}

class VibrationForFlyDependencyServiceModel: FlyService {
    
    static var path: Path = "fliesTests/VibrationForFlyDependencyServiceModel"
    
    static var dependencies: [DependencyType] = [.required("anyDependency")]
    
    var startCalled = false
    
    static func newInstance() -> Self {
        return VibrationForFlyDependencyServiceModel() as! Self
    }
    
    func start(with parameters: BaseType?) throws {
        startCalled = true
    }
}
