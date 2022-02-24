//
//  SecondFrameworkRegister.swift
//  SecondFramework
//
//  Created by Andre Luiz Salla on 08/06/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

public class SecondFrameworkRegister: FlyRegister {
    
    public static var registrableFlies: [FlyBase.Type] {
        return [MyTestClassSecond.self, NetworkService.self]
    }
    
}
