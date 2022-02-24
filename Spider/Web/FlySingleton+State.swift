//
//  FlySingleton+State.swift
//  Spider
//
//  Created by André Salla on 13/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

enum FlySingletonState {
    case idle
    case running
}

fileprivate struct FlySingletonKeys {
    static var state: UInt8 = 0
}

extension FlySingleton {
    
    var state: FlySingletonState {
        get {
            if let state =
                objc_getAssociatedObject(self,
                                         &FlySingletonKeys.state) as? FlySingletonState {
                return state
            }
            self.state = .idle
            return .idle
        }
        set {
            objc_setAssociatedObject(self,
                                     &FlySingletonKeys.state,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
