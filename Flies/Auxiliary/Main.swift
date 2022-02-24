//
//  Main.swift
//  Flies
//
//  Created by Andre Luiz Salla on 08/06/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

public protocol Main: AnyObject {
    static var vibration: Vibration { get }
}
