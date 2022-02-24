//
//  FlyCodable.swift
//  Flies
//
//  Created by André Salla on 12/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

public protocol FlyCodable: FlyTypes where Input: Codable,
                                           Output: Codable {
    
}

public extension FlyCodable {
    
    func toInput(from dictionary: [String : Any]?) throws -> Input? {
        return try CodableUtils.toCodable(dictonary: dictionary)
    }
    
    func toDictionary(from output: Output?) throws -> [String: Any]? {
        return try CodableUtils.toDictionary(codable: output)
    }
    
}
