//
//  RegisterDependenciesTest.swift
//  FliesTests
//
//  Created by André Salla on 21/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class RegisterDependenciesTest: FlyRegister {
    static var registrableFlies: [FlyBase.Type] = [FlowRegistrableTest.self,
                                                   ServiceRegistrableTest.self]
}
