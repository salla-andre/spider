//
//  WebFlySingletonTestModel.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

final class WebFlySingletonTestModel: FlyService, FlySingleton {
    static var path: Path { "spiderTests/WebFlySingletonTestModel" }
    
    static var dependencies: [DependencyType] = []
    
    var startIsCalled = false

    init() { }
    
    func start(with parameters: Dictionary<String, Any>?) throws {
        startIsCalled = true
    }
}
