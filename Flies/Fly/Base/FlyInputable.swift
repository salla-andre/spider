//
//  FlyInputable.swift
//  Flies
//
//  Created by André Salla on 12/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

public protocol FlyInputable {
    
    associatedtype Input
    
    func toInput(from dictionary: BaseType?) throws -> Input?
    
}
