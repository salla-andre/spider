//
//  MyTestClassSecond.swift
//  SecondFramework
//
//  Created by Andre Luiz Salla on 14/07/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies
import UIKit

public final class MyTestClassSecond: FlyCodableFlow, FlySingleton {

    public typealias Output = ResultColor
    public typealias Input = ResultColor
        
    public static var path: String {
        return "path/second"
    }
    
    public static var dependencies: [DependencyType] { [] }
    
    public init() { }
    
    public func start(with parameters: ResultColor?) -> UIViewController {
        let viewController = TestViewController()
        
        if let hexColor = parameters?.backgroundColor,
           let backGroundColor = UIColor(hex: hexColor) {
            viewController.view.backgroundColor = backGroundColor
        } else {
            viewController.view.backgroundColor = .blue
        }
        
        return viewController
    }
    
    internal func stop(with selection: String) {
        finish(resulting: .success(ResultColor(backgroundColor: selection)))
    }

}
