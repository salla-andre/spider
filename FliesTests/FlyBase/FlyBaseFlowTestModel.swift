//
//  FlyBaseFlowTestModel.swift
//  FliesTests
//
//  Created by André Salla on 17/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies
import UIKit

class FlyBaseFlowTestModel: FlyBaseFlow {
    
    static var path: Path { "flyTests/FlyBaseFlowTestModel" }
    
    static var dependencies: [DependencyType] = []
    
    static func newInstance() -> Self {
        return FlyBaseFlowTestModel() as! Self
    }
    
    var startClosure: BaseCallback?
    
    func start(with parameters: BaseType?) throws -> UIViewController {
        startClosure?(.success(parameters))
        return UIViewController()
    }
}
