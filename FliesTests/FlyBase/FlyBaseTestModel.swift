//
//  FlyBaseTestModel.swift
//  FliesTests
//
//  Created by André Salla on 17/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class FlyBaseTestModel: FlyBase {
    
    static var path: Path { "flyTests/FlyBaseTestModel" }
    
    static var dependencies: [DependencyType] = []
    
    static func newInstance() -> Self {
        return FlyBaseTestModel() as! Self
    }
    
    
}
