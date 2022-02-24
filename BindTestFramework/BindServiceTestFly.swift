//
//  BindServiceTestFly.swift
//  BindTestFramework
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class BindServiceTestFly: FlyService {
    
    static var path: Path {"spiderTests/BindServiceTestFly"}
    
    static var dependencies: [DependencyType] { [] }
    
    static func newInstance() -> Self {
        guard let instance = BindServiceTestFly() as? Self else {
            fatalError()
        }
        return instance
    }
    
    func start(with parameters: BaseType?) throws {
        
    }
    
}

