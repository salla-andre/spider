//
//  FlyCapsuleTestModel.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class FlyCapsuleTestModel: FlyBase {
 
    static var path: Path { "spiderTest/capsuleTest" }
    
    ///All dependency paths used in your Fly
    static var dependencies: [DependencyType] { [] }

    ///The logic used to create your Fly
    static func newInstance() -> Self {
        guard let model = FlyCapsuleTestModel() as? Self else {
            fatalError()
        }
        return model
    }
    
}
