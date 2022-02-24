//
//  FlySingleton.swift
//  Flies
//
//  Created by André Salla on 13/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct FlySingletonKeys {
    static var instance: UInt8 = 0
}

public protocol FlySingleton: AnyObject {
    init()
}

public extension FlySingleton where Self: FlyBase {
    
    internal static var instance: Self {
        get {
            if let value =
                objc_getAssociatedObject(self,
                                         &FlySingletonKeys.instance) as? Self {
                return value
            }
            let value = Self()
            objc_setAssociatedObject(self, &FlySingletonKeys.instance,
                                     value,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return value
        }
    }
    
    static func newInstance() -> Self {
        self.shared
    }
    
    static var shared: Self {
        return instance
    }
    
}
