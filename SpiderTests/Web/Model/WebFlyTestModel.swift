//
//  WebFlyTestModel.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class WebFlyTestModel: FlyBase {
    static var path: Path { "spiderTests/WebFlyTestModel" }
    
    static var dependencies: [DependencyType] = []
    
    static func newInstance() -> Self {
        guard let instance = WebFlyTestModel() as? Self else {
            fatalError()
        }
        return instance
    }
}
