//
//  ServiceRegistrableTest.swift
//  FliesTests
//
//  Created by André Salla on 21/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class ServiceRegistrableTest: FlyService {
    
    static var path: Path { "flyTests/serviceTests" }
    
    static var dependencies: [DependencyType] = []
    
    var startCalled = false
    
    static func newInstance() -> Self {
        ServiceRegistrableTest() as! Self
    }
    
    func start(with parameters: BaseType?) throws {
        startCalled = true
    }
    
}
