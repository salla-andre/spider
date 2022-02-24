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
            case .required(let path, let version): return path
            case .optional(let path, let version): return path
            }
        }.contains(dependency)
    }
    
    private func checkVersion(current: String, needed: String? = nil) -> Bool {
        guard let needed = needed else {
            return true
        }
        
        var neededComposed = needed.split(separator: ".")
        var currentComposed = current.split(separator: ".")
        
        var isCompatible = true
        var compareFactor = "="
        
        if let firstPartNeeded = neededComposed.first,
           let majorCurrent = currentComposed.first {
            compareFactor = firstPartNeeded.filter{ $0.isMathSymbol }
            let majorNeeded = firstPartNeeded.filter{ !$0.isMathSymbol }
            isCompatible = isCompatible && (majorNeeded != "") && (majorNeeded == majorCurrent)
        }
        
        if neededComposed.count > 1 {
            let minorNeeded = String(neededComposed[1])
            let minorCurrent = currentComposed.count > 1 ? currentComposed[1] : "0"
            isCompatible = isCompatible && compare(left: minorNeeded, right: minorCurrent, factor: compareFactor)
        }
        
    }
    
    private func compare(left: String, right: String, factor: String) -> Bool {
        guard let numberLeft = Int(left), let numberRight = Int(right) else {
            return false
        }
        switch factor {
        case "=": return numberLeft == numberRight
        case ">": return numberLeft > numberRight
        case "<": return numberLeft < numberRight
        case ">=": return numberLeft >= numberRight
        case "<=": return numberLeft <= numberRight
        default: return false
        }
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
