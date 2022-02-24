//
//  CodableUtilTests.swift
//  FliesTests
//
//  Created by André Salla on 19/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

@testable import Flies
import XCTest

class CodableUtilTests: XCTestCase {

    func testSwiftConvertible() throws {
        let value: [String: Any] = [
            "valueString": NSString(string: "Value"),
            "valueInt": NSNumber(value: 32 as UInt),
            "valueDouble": NSNumber(value: 100.55 as Double),
            "valueFloat": NSNumber(value: 100.55 as Float),
            "valueBool": NSNumber(value: true),
            "valueNull": NSNull(),
            "valueArray": NSArray(array: [NSString(string: "arrayString"),
                                          NSNumber(value: 32 as Int)]),
            "valueDictionary": NSDictionary(dictionary: ["valueDictionary1": NSNumber(value: 32.9 as Double)])
        ]
        var resultValue: [String: Any]? = nil
        XCTAssertNoThrow(resultValue = try CodableUtils.convertSwift(dictionary: value))
        XCTAssertNotNil(resultValue)
        if let resultValue = resultValue {
            XCTAssert(resultValue["valueString"] is String)
            XCTAssert(resultValue["valueInt"] is Int)
            XCTAssert(resultValue["valueDouble"] is Double)
            XCTAssert(resultValue["valueFloat"] is Float)
            XCTAssert(resultValue["valueBool"] is Bool)
            XCTAssertNil(resultValue["valueNull"])
            XCTAssert(resultValue["valueArray"] is Array<Any>)
            XCTAssert(resultValue["valueDictionary"] is Dictionary<String, Any>)
        } else {
            XCTFail("Nil value for resultValue")
        }
        
    }
    
    func testSwiftConvertibleError() throws {
        let value = NSNumber(value: CUnsignedLongLong.max as CUnsignedLongLong)
        XCTAssertThrowsError(try CodableUtils.convertSwift(value: value), "") { error in
            XCTAssertEqual((error as? InternalError), .parserError)
        }
    }
    
    func testSwiftConvertibleNotDictionaryError() throws {
        let dataArray = [["Value": 1], ["Value": 4]]
        let dataJson = try JSONSerialization.data(withJSONObject: dataArray, options: .fragmentsAllowed)
        XCTAssertThrowsError(try CodableUtils.toDictionary(data: dataJson)) { error in
            XCTAssertEqual((error as? InternalError), .parserError)
        }
    }
    
    func testCodableToDictionary() throws {
        let encodable = EncodableTestModel(name: "Value",
                                           age: 32,
                                           value: 100.55,
                                           additionalInfo: nil,
                                           child: [EncodableChildTestModel(name: "Child 1"),
                                                   EncodableChildTestModel(name: "Child 2")],
                                           wife: EncodableChildTestModel(name: "Wife"),
                                           active: true)
        var dictionary: [String: Any]? = nil
        XCTAssertNoThrow(dictionary =
                         try CodableUtils.toDictionary(codable: encodable))
        XCTAssertEqual(dictionary?["name"] as? String, "Value")
        XCTAssertEqual(dictionary?["age"] as? Int, 32)
        XCTAssertEqual(dictionary?["value"] as? Double, 100.55)
        XCTAssertNil(dictionary?["additionalInfo"])
        XCTAssertEqual(dictionary?["child"] as? [[String: String]],
                       [["name": "Child 1"], ["name": "Child 2"]])
        XCTAssertEqual(dictionary?["wife"] as? [String: String], ["name": "Wife"])
        XCTAssertEqual(dictionary?["active"] as? Bool, true)
        
    }
    
    func testDictionaryToCodable() throws {
        let encodable = EncodableTestModel(name: "Value",
                                           age: 32,
                                           value: 100.55,
                                           additionalInfo: nil,
                                           child: [EncodableChildTestModel(name: "Child 1"),
                                                   EncodableChildTestModel(name: "Child 2")],
                                           wife: EncodableChildTestModel(name: "Wife"),
                                           active: true)
        var encodableCheck: EncodableTestModel? = nil
        var dictionary: [String: Any] = [:]
        dictionary["name"] = "Value"
        dictionary["age"] = 32
        dictionary["value"] = 100.55
        dictionary["child"] = [["name": "Child 1"], ["name": "Child 2"]]
        dictionary["wife"] = ["name": "Wife"]
        dictionary["active"] = true
        XCTAssertNoThrow(encodableCheck =
                         try CodableUtils.toCodable(dictonary: dictionary))
        XCTAssertEqual(encodableCheck?.name, encodable.name)
        XCTAssertEqual(encodableCheck?.age, encodable.age)
        XCTAssertEqual(encodableCheck?.value, encodable.value)
        XCTAssertEqual(encodableCheck?.additionalInfo, encodable.additionalInfo)
        XCTAssertEqual(encodableCheck?.child.count, encodable.child.count)
        XCTAssertEqual(encodableCheck?.child[0].name, encodable.child[0].name)
        XCTAssertEqual(encodableCheck?.child[1].name, encodable.child[1].name)
        XCTAssertEqual(encodableCheck?.wife?.name, encodable.wife?.name)
        XCTAssertEqual(encodableCheck?.active, encodable.active)
    }
    
    func testNilDictionaryToCodable() throws {
        var encodableCheck: EncodableTestModel? = nil
        XCTAssertNoThrow(encodableCheck =
                         try CodableUtils.toCodable(dictonary: nil))
        XCTAssertNil(encodableCheck)
    }
    
    func testDictionaryNotCodableToCodable() throws {
        let dictionary: [String: Any] = ["view": UIView()]
        var encodableCheck: EncodableTestModel? = nil
        XCTAssertThrowsError(encodableCheck = try CodableUtils.toCodable(dictonary: dictionary), "", { error in
            XCTAssertEqual((error as? InternalError), .parserError)
        })
        XCTAssertNil(encodableCheck)
    }
}

