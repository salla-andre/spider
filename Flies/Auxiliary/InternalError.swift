//
//  FlyError.swift
//  Flies
//
//  Created by André Salla on 02/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

public enum InternalError: Error {
    /// An error caused when two different Flies (Flow or Service) have the same path
    case duplicatedFly
    /// An error caused when you try to vibrate to a flow or service that is not binded
    case flyNotFound
    /// An error caused when you try to vibrate to a Flow that is mapped as a Service
    case flyIsNotFlow
    /// An error caused when you try to vibrate to a Service that is mapped as a Flow
    case flyIsNotService
    ///
    case invalidParameters
    ///
    case invalidStateForStartRegister
    ///
    case invalidStateForFinishRegister
    ///
    case registerWithoutStart
    ///
    case missingDependencies
    ///
    case parserError
    ///
    case callingMissingDependency
    
    case singletonIsBusy
}
