//
//  FlyRegister.swift
//  Flies
//
//  Created by Andre Luiz Salla on 07/04/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

/// Register flies
public protocol FlyRegister: AnyObject {
    static var registrableFlies: [FlyBase.Type] { get }
}
