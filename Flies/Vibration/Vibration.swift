//
//  Vibration.swift
//  Flies
//
//  Created by Andre Luiz Salla on 14/07/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation

/**
    Vibration is the protocol used to allow Spider to access Flies binded to the framework.
 
    - important: You shouldn't implement Vibration anywhere. Just use `vibration`in `Fly` to access another Flies. Spider will take care of provide you a usable Vibration implementation.
*/
public protocol VibrationBase: AnyObject {
    /**
        Start your flow with the given parameters in a dictionary info.
        
        - parameters:
            - onComplete: the callback used to inform to Spider that your flow is done, with a Result to return some data to caller.
            
        - important: `onComplete` should ALWAYS be called to prevent retain-cicle.
    */
    func isAvailable(signal: FlyBase.Path) -> Bool

}

public typealias Vibration = VibrationCodable & VibrationDictionary
