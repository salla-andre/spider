//
//  FlyValidable.swift
//  Flies
//
//  Created by André Salla on 16/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

public protocol FlyBaseValidable {
    func validation(with parameters: BaseType?) throws
}

public protocol FlyValidable: FlyBaseValidable {
    
    associatedtype Parameter
    
    func validate(parameters: Parameter?) throws
    
}

public extension FlyTypes where Self: FlyValidable {
    
    func validate(parameters: Parameter?) throws {
        //Default - does nothing
    }
    
}

public extension FlyBaseValidable where Self: FlyValidable, Self: FlyInputable, Self.Parameter == Self.Input {
    func validation(with parameters: BaseType?) throws {
        try self.validate(parameters: toInput(from: parameters))
    }
}
