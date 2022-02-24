//
//  WebCapsuleTest.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies
@testable import Spider

class WebCapsuleTest: Capsulable {
    
    var detachedCalled: Bool = false
    
    func attach(fly: FlyBase, callback: BaseCallback?) -> Capsule {
        fatalError("Does nothing now")
    }
    
    func deAttach(capsule: Capsule?) {
        detachedCalled = true
    }

}
