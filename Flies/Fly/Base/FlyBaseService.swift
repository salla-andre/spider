//
//  FlyBaseService.swift
//  Flies
//
//  Created by André Salla on 12/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

/**
    FlyService is the protocol used to design a Fly for a specific  service.
 
    - important: `onComplete` should ALWAYS be called to inform Spider hat your service is done, even if it has no returns.
*/
public protocol FlyBaseService: FlyBase {
    /**
        Start your service with the given parameters in a dictionary info.
        
        - parameters:
            - parameters: the parameters used as input for your service to start
            
        - important: `finish(resulting:)` should ALWAYS be called to prevent retain-cicle.
    */
    func start(with parameters: BaseType?) throws
}

public extension FlyBaseService {
    /**
        Start your service with the given parameters in a dictionary info.
            
        - important: `finish(resulting:)` should ALWAYS be called to prevent retain-cicle.
    */
    func start() throws {
        try start(with: nil)
    }
}
