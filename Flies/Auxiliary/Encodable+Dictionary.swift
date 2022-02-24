//
//  SpiderParseable.swift
//  Flies
//
//  Created by André Salla on 03/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

internal extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let dictionary = try CodableUtils.toDictionary(data: data)
        return try CodableUtils.convertSwift(dictionary: dictionary)
    }
}

public class CodableUtils {
    internal static func convertSwift(dictionary: [String: Any]) throws -> [String: Any] {
        var cleanDictionary: [String: Any] = [:]
        try dictionary.forEach { key, value in
            if let swiftValue = try convertSwift(value:value) {
                cleanDictionary[key] = swiftValue
            }
        }
        return cleanDictionary
    }
    
    internal static func toDictionary(data: Data) throws -> [String: Any] {
        guard let dictionary =
                try JSONSerialization.jsonObject(with: data,
                                                 options: .fragmentsAllowed) as? [String: Any] else {
                    throw InternalError.parserError
        }
        return dictionary
    }

    internal static func convertSwift(value: Any) throws -> Any? {
        if let nsnumber = value as? NSNumber {
            let encoding = String(cString: nsnumber.objCType)
            switch encoding {
            case "d": return nsnumber.doubleValue
            case "f": return nsnumber.floatValue
            case "q": return nsnumber.intValue
            case "c": return nsnumber.boolValue
            default: throw InternalError.parserError
            }
        } else if let nsstring = value as? NSString {
            return String(nsstring)
        } else if let dict = value as? [String: Any] {
            return try convertSwift(dictionary: dict)
        } else if let array = value as? [Any] {
            return try array.compactMap { try convertSwift(value: $0) }
        } else if value is NSNull {
            return nil
        }
        return value
    }
    
    public static func checkEncodable(for value: Any) -> Bool {
        var checkedOk = true
        if let dict = value as? [String: Any] {
            dict.forEach { key, dictValue in
                checkedOk = checkedOk && checkEncodable(for: dictValue)
            }
        } else if let array = value as? [Any] {
            array.forEach { arrayValue in
                checkedOk = checkedOk && checkEncodable(for: arrayValue)
            }
        } else {
            checkedOk = checkedOk && ((value as? Encodable) != nil)
        }
        return checkedOk
    }
    
    
    public static func toCodable<T: Codable>(dictonary: [String: Any]?) throws -> T? {
        guard let dictonary = dictonary else {
             return nil
        }
        if checkEncodable(for: dictonary),
           let data = try? JSONSerialization.data(withJSONObject: dictonary,
                                                  options: .prettyPrinted),
           let decoded = try? JSONDecoder().decode(T.self, from: data) {
            return decoded
        }
        throw InternalError.parserError
    }
    
    public static func toDictionary<T: Codable>(codable: T?) throws -> [String: Any]? {
        return try codable?.toDictionary()
    }
}
