//
//  WebFlyTestModel.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class WebFlyDependencyTestModel: FlyBase {
    static var path: Path { "spiderTests/WebFlyDependencyTestModel" }
    
    static var dependencies: [DependencyType] { [.required(WebFlyTestModel.path),
                                                 .optional(WebFlyTestModel.path)] }
    
    static func newInstance() -> Self {
        guard let instance = WebFlyDependencyTestModel() as? Self else {
            fatalError()
        }
        return instance
    }
}
