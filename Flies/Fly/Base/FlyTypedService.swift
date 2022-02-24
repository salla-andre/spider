//
//  Fly.swift
//  Flies
//
//  Created by Andre Luiz Salla on 13/07/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation

/**
    FlyService is the protocol used to design a Fly for a specific  service.
 
    - important: `onComplete` should ALWAYS be called to inform Spider hat your service is done, even if it has no returns.
*/
public protocol FlyTypedService: FlyInOut, FlyBaseService {
    /**
        Start your service with the given parameters in a dictionary info.
        
        - parameters:
            - parameters: the parameters used as input for your service to start
            
        - important: `finish(resulting:)` should ALWAYS be called to prevent retain-cicle.
    */
    func start(with parameters: Input?) throws
}

public extension FlyTypedService {
    
    func start(with parameters: BaseType?) throws {
        try self.start(with: try toInput(from: parameters))
    }
    
}
