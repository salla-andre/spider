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
public protocol VibrationDictionary: VibrationBase {
    
    

    /**
        Method used to call a Flow with Spider.
        
        - parameters:
            - signal: the path of the flow you want to call
            - style: the `PresentationStyle` that the flow will use to be displayed.
            - parameters: the parameters used as input for the flow to start
            - completion: the callback called when the flow is done.
        
    */
    func flow(signal: String,
              style: PresentationType,
              parameters: BaseType?,
              completion: BaseCallback?) throws
    /**
        Method used to call a Service with Spider.
        
        - parameters:
            - signal: the path of the service you want to call
            - parameters: the parameters used as input for the service to start
            - completion: the callback called when the service is done.

    */
    func service(signal: String,
                 parameters: BaseType?,
                 completion: BaseCallback?) throws
}

public extension VibrationDictionary {
    
    /**
        Method used to call a Flow with Spider without parameters, no callback, and `PresentationType.present` as default style.
        
        - parameters:
            - signal: the path of the flow you want to call
        
        - important: `PresentationType.present` will be used as style
     
    */
    func flow(signal: String) throws {
        try self.flow(signal: signal,
                      style: .present,
                      parameters: nil,
                      completion: nil)
    }
    /**
        Method used to call a Flow with Spider with `PresentationType.present` as default style.
        
        - parameters:
            - signal: the path of the flow you want to call
            - parameters: the parameters used as input for the flow to start
            - completion: the callback called when the flow is done.
        
        - important: `PresentationType.present` will be used as style
        
    */
    func flow(signal: String,
              parameters: BaseType?,
              completion: BaseCallback?) throws {
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
    func flow(signal: String,
              style: PresentationType,
              completion: BaseCallback?) throws {
        try self.flow(signal: signal,
                      style: style,
                      parameters: nil,
                      completion: completion)
    }
    /**
        Method used to call a Flow with Spider without parameters and `PresentationType.present` as default style.
        
        - parameters:
            - signal: the path of the flow you want to call
            - completion: the callback called when the flow is done.
        
        - important: `PresentationType.present` will be used as style
        
    */
    func flow(signal: String,
              completion: BaseCallback?) throws {
        try self.flow(signal: signal,
                      style: .present,
                      parameters: nil,
                      completion: completion)
    }
    
}
