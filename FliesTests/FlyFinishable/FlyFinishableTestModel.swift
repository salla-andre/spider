//
//  FlyFinishableTestModel.swift
//  FliesTests
//
//  Created by André Salla on 21/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class FlyFinishableTestModel: FlyBase, FlyCodableService, FlySingleton {
    
    static var path: Path { "flyTests/FlyFinishableTestModel" }
    
    static var dependencies: [DependencyType] = []
    
    required init(){ }
    
    typealias Input = EncodableTestModel
    
    typealias Output = EncodableTestModel
    
    var shouldSucceedToDictionary = true
    
    func start(with parameters: EncodableTestModel?) throws { }
    
    func toDictionary(from output: EncodableTestModel?) throws -> BaseType? {
        if shouldSucceedToDictionary {
            return try CodableUtils.toDictionary(codable: output)
        }
        throw InternalError.parserError
    }
    
}

class FlyFinishableTestRegister: FlyRegister {
    static var registrableFlies: [FlyBase.Type] = [FlyFinishableTestModel.self]
}
