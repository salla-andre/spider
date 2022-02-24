//
//  FlyFlow.swift
//  Flies
//
//  Created by Andre Luiz Salla on 07/12/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

public protocol FlyTypedFlow: FlyInOut, FlyBaseFlow {
    /**
        Start your flow with the given parameters in a dictionary info.
        
        - parameters:
            - parameters: the parameters used as input for your flow to start
            - onComplete: the callback used to inform to Spider that your flow is done, with a Result to return some data to caller.
            
        - important: `finish(resulting:)` should ALWAYS be called to prevent retain-cicle.
    */
    func start(with parameters: Input?) throws -> UIViewController
}

public extension FlyTypedFlow {
    
    func start(with parameters: BaseType?) throws -> UIViewController {
        try self.start(with: try toInput(from: parameters))
    }
    
}
