//
//  Web.swift
//  Spider
//
//  Created by Andre Luiz Salla on 18/08/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

final class Web: WebProtocol {
    
    private var flies: [String: FlyBase.Type] = [:]
    private var web: Set<Capsule> = []
    private var internalWindowsArraySource: AvailableWindowsGetable?
    var windowsArraySource: AvailableWindowsGetable? {
        get {
            if internalWindowsArraySource == nil {
                internalWindowsArraySource = self
            }
            return internalWindowsArraySource
        }
        set {
            internalWindowsArraySource = newValue
        }
    }
    
    internal func bind(fly: FlyBase.Type) throws {
        if let current = flies[fly.path] {
            print("Duplicated fly for path \"\(fly.path)\": Old \(current) | New \(fly) ")
            throw InternalError.duplicatedFly
        } else {
            flies[fly.path] = fly
        }
    }
    
    internal func getFly(for path: FlyBase.Path) throws -> FlyBase.Type {
        if let fly = flies[path] {
            return fly
        }
        throw InternalError.flyNotFound
    }
    
    internal func validadeDependencies() throws {
        
        let paths = flies.map { $0.value }.flatMap { $0.dependencies }.compactMap { dependency -> String? in
            if case let .required(path) = dependency {
                return path
            }
            return nil
        }
        let requiredDependencies = Set(paths)
        let availablePaths = flies.map { $0.key }
        let missingDependencies = requiredDependencies.filter { !availablePaths.contains($0) }
        if missingDependencies.count > 0 {
            print("One or more dependencies are missing.")
            missingDependencies.forEach{ print($0) }
            throw InternalError.missingDependencies
        }
        
    }
}

extension Web: Capsulable {

    internal func attach(fly: FlyBase,
                         callback: BaseCallback?) -> Capsule {
        let capsule = Capsule(fly: fly)
        capsule.web = self
        capsule.set(callback: callback)
        web.insert(capsule)
        return capsule
    }
    
    internal func deAttach(capsule: Capsule?) {
        if let sCapsule = capsule {
            self.web.remove(sCapsule)
        }
    }
    
}

