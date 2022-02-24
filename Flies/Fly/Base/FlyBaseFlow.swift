//
//  FlyBaseFlow.swift
//  Flies
//
//  Created by André Salla on 12/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

///PresentationType represents the ways your flow should be displayed
public enum PresentationType {
    ///Present style will make your flow to be presented over the previous flow, just like `viewController.present(anotherViewController, animated: true, completion: nil)` whould do
    case present
    ///Push style will make your flow to be pushed over a UINavigationViewController, just like `navigation.pushViewController(viewController, animated: true)` whould do
    case push
}

/**
    FlyFlow is the protocol used to design a Fly for a specific asynchronous flow.
 
    - important: `finish(resulting:)` should ALWAYS be called to inform Spider and the previous flow that your flow is done.
*/
public protocol FlyBaseFlow: FlyBase {
    /**
        Start your flow with the given parameters in a dictionary info.
        
        - parameters:
            - parameters: the parameters used as input for your flow to start
            - onComplete: the callback used to inform to Spider that your flow is done, with a Result to return some data to caller.
            
        - important: `finish(resulting:)` should ALWAYS be called to prevent retain-cicle.
    */
    func start(with parameters: BaseType?) throws -> UIViewController
}

public extension FlyBaseFlow {
    /**
        Start your flow with the given parameters in a dictionary info.
    */
    func start() throws -> UIViewController {
        try start(with: nil)
    }
}
