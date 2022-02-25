//
//  VibrationForFly.swift
//  Flies
//
//  Created by André Salla on 02/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

internal class VibrationForFly: Vibration {
    
    var original: Vibration
    weak var fly: FlyBase?
    
    init?(vibration: Vibration?, source: FlyBase?) {
        guard let vibration = vibration, let source = source else {
            return nil
        }
        original = vibration
        fly = source
    }
    
    func isAvailable(signal: String) -> Bool {
        original.isAvailable(signal: signal)
    }
    
    func service(signal: String,
                 parameters: BaseType?,
                 completion: BaseCallback?) throws {
        guard check(dependency: signal) else {
            throw InternalError.callingMissingDependency
        }
        try original.service(signal: signal,
                            parameters: parameters,
                            completion: completion)
    }
    
    func flow(signal: String, style: PresentationType,
              parameters: BaseType?,
              completion: BaseCallback?) throws {
        guard check(dependency: signal) else {
            throw InternalError.callingMissingDependency
        }
        try original.flow(signal: signal,
                          style: style,
                          parameters: parameters,
                          completion: completion)
    }
    
    private func check(dependency: String, version: String? = nil) -> Bool {
        guard let fly = fly else { return false }
        return type(of: fly).dependencies.map {
            switch $0 {
            case .required(let path): return path
            case .optional(let path): return path
            }
        }.contains(dependency)
    }
    
    func flow<T: Codable, U: Codable>(signal: String,
                                      style: PresentationType,
                                      parameters: T?,
                                      completion: CallbackResult<U>?) throws {
        guard check(dependency: signal) else {
            throw InternalError.callingMissingDependency
        }
        try original.flow(signal: signal,
                          style: style,
                          parameters: parameters,
                          completion: completion)
    }
    
    func service<T: Codable, U: Codable>(signal: String,
                                         parameters: T?,
                                         completion: CallbackResult<U>?) throws {
        guard check(dependency: signal) else {
            throw InternalError.callingMissingDependency
        }
        try original.service(signal: signal,
                             parameters: parameters,
                             completion: completion)
    }
}
