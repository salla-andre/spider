//
//  FirstFrameworkRegister.swift
//  FirstFramework
//
//  Created by Andre Luiz Salla on 08/06/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

public class FirstFrameworkRegister: FlyRegister {
    
    static public var registrableFlies: [FlyBase.Type] {
        return [MyTestClassFirst.self]
    }
    
}
