//
//  FlyFinishable.swift
//  Flies
//
//  Created by André Salla on 12/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

public protocol FlyFinishable: FlyBaseFinishable {
    
    associatedtype Output
    
    func finish(resulting: ResultValue<Output>?)
    
    func toDictionary(from output: Output?) throws -> BaseType?
    
}

public extension FlyFinishable where Self: FlyBase {
    
    func finish(resulting: ResultValue<Output>?) {
        switch resulting {
        case .success(let output):
            do {
                defaultFinish(resulting:
                                    .success(try toDictionary(from: output)),
                              for: self)
            } catch {
                defaultFinish(resulting: .failure(error), for: self)
            }
        case .failure(let error):
            defaultFinish(resulting: .failure(error), for: self)
        case .none:
            defaultFinish(resulting: nil as BaseResult?, for: self)
        }
    }
    
}
