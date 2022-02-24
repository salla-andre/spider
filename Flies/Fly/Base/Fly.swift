//
//  Fly.swift
//  Flies
//
//  Created by Andre Luiz Salla on 13/07/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation

/**
    Fly protocol is the ancestor of all Fly type protocols. It contains the basics for any Fly (Flow or Service)
 
    - important: `vibration` is set by Spider. You should never change its value.
*/
public protocol FlyBase: AnyObject {
    
    typealias Path = String

    ///The path used to Spider to map your Fly
    static var path: Path { get }
    
    ///All dependency paths used in your Fly
    static var dependencies: [DependencyType] { get }

    ///The logic used to create your Fly
    static func newInstance() -> Self
    
}

fileprivate struct FlyKeys {
    static var vibrate: UInt8 = 0
}

public extension FlyBase {

    ///Vibration is the class that allows your Fly to vibrate trought other Flies. It's set by Spider and should never be changed.
    var vibration: Vibration? {
        get {
            if Self.spiderVibration == nil {
                Self.spiderVibration = getMainVibration()
            }
            return VibrationForFly(vibration: Self.spiderVibration, source: self)
        }
    }

}

internal extension FlyBase {
    
    static var spiderVibration: Vibration? {
        get {
            return objc_getAssociatedObject(self, &FlyKeys.vibrate) as? Vibration
        }
        set {
            objc_setAssociatedObject(self,
                                     &FlyKeys.vibrate,
                                     newValue,
                                     .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func getMainVibration() -> Vibration? {
        let mainSpider = Bundle.allFrameworks
            .compactMap{ $0.principalClass as? Main.Type }.first
        return mainSpider?.vibration
    }
    
}

public typealias FlyInOut = FlyTypes & FlyInputable & FlyFinishable & FlyValidable
