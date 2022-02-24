//
//  DumySingletonFly.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

final class DummySingletonFly: FlyBase, FlySingleton {
    
    static var path: Path = "spiderTests/DummySingletonFly"
    
    static var dependencies: [DependencyType] = []
    
    init() { }
    
}
