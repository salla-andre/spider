//
//  FlyValidable.swift
//  Flies
//
//  Created by André Salla on 16/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

public protocol FlyValidable {
    
    associatedtype Parameter
    
    func validate(parameters: Parameter?) -> Bool
    
}

public extension FlyTypes where Self: FlyValidable {
    
    func validate(parameters: Parameter?) -> Bool {
        return true
    }
    
}
