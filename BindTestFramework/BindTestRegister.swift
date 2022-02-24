//
//  BindTestRegister.swift
//  BindTestFramework
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class BindTestRegister: FlyRegister {
    static var registrableFlies: [FlyBase.Type] = [BindFlowTestFly.self,
                                                   BindServiceTestFly.self]
}
