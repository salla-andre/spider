//
//  FlyFlow.swift
//  Flies
//
//  Created by André Salla on 12/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

public protocol FlyFlow: FlyBaseFlow, FlyInputable, FlyFinishable, FlyValidable where Self.Input == [String: Any], Self.Output == [String: Any], Self.Input == Self.Parameter {
}

extension FlyFlow {
    public func toInput(from dictionary: BaseType?) throws -> Input? {
        return dictionary
    }
    
    public func toDictionary(from output: Output?) throws -> BaseType? {
        return output
    }
    
    public func validate(parameters: Parameter?) -> Bool {
        return true
    }
}
