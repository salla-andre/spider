//
//  Vibration.swift
//  Flies
//
//  Created by Andre Luiz Salla on 14/07/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation

public protocol VibrationCodable: VibrationBase {
    
    /**
        Method used to call a Flow with Spider.
        
        - parameters:
            - signal: the path of the flow you want to call
            - style: the `PresentationStyle` that the flow will use to be displayed.
            - parameters: the parameters used as input for the flow to start
            - completion: the callback called when the flow is done.
        
    */
    func flow<T: Codable, U: Codable>(signal: String,
                                      style: PresentationType,
                                      parameters: T?,
                                      completion: CallbackResult<U>?) throws
    /**
        Method used to call a Service with Spider.
        
        - parameters:
            - signal: the path of the service you want to call
            - parameters: the parameters used as input for the service to start
            - completion: the callback called when the service is done.

    */
    func service<T: Codable, U: Codable>(signal: String,
                                         parameters: T?,
                                         completion: CallbackResult<U>?) throws
}

public extension VibrationCodable {
    
    /**
        Method used to call a Flow with Spider with `PresentationType.present` as default style.
        
        - parameters:
            - signal: the path of the flow you want to call
            - parameters: the parameters used as input for the flow to start
            - completion: the callback called when the flow is done.
        
        - important: `PresentationType.present` will be used as style
        
    */
    func flow<T: Codable, U: Codable>(signal: String,
              parameters: T?,
              completion: CallbackResult<U>?) throws {
        
        try self.flow(signal: signal,
                      style: .present,
                      parameters: parameters,
                      completion: completion)
    }
    /**
        Method used to call a Flow with Spider without parameters.
        
        - parameters:
            - signal: the path of the flow you want to call
            - style: the `PresentationStyle` that the flow will use to be displayed.
            - completion: the callback called when the flow is done.
        
    */
    func flow<T: Codable>(signal: String,
              style: PresentationType,
              completion: CallbackResult<T>?) throws {
        try self.flow(signal: signal,
                      style: style,
                      parameters: Empty(),
                      completion: completion)
    }
    /**
        Method used to call a Flow with Spider without parameters and `PresentationType.present` as default style.
        
        - parameters:
            - signal: the path of the flow you want to call
            - completion: the callback called when the flow is done.
        
        - important: `PresentationType.present` will be used as style
        
    */
    func flow<T: Codable>(signal: String,
              completion: CallbackResult<T>?) throws {
        try self.flow(signal: signal,
                      style: .present,
                      parameters: Empty(),
                      completion: completion)
    }
    
}
