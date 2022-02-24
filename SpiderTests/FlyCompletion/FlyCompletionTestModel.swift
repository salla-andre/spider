//
//  FlyCompletionTestModel.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class FlyCompletionTestModel: FlyBase, FlyFinishable {
    
    func toDictionary(from output: [String : Any]?) throws -> BaseType? {
        return output
    }
    
    static var path: Path { "spiderTests/FlyCompletionTestModel" }
    
    static var dependencies: [DependencyType] = []
    
    static func newInstance() -> Self {
        guard let instance = FlyCompletionTestModel() as? Self else {
            fatalError()
        }
        return instance
    }
    
    typealias Output = [String: Any]
    
    
}
