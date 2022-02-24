//
//  FlyCodableTests.swift
//  FliesTests
//
//  Created by André Salla on 21/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
@testable import Flies

class FlyCodableTests: XCTestCase {

    func testFlyCodableToInput() throws {
        let fly = FlyCodableTestModel()
        var dictionary: [String: Any] = [:]
        dictionary["name"] = "Value"
        dictionary["age"] = 32
        dictionary["value"] = 100.55
        dictionary["child"] = [["name": "Child 1"], ["name": "Child 2"]]
        dictionary["wife"] = ["name": "Wife"]
        dictionary["active"] = true
        var input: FlyCodableTestModel.Input? = nil
        XCTAssertNoThrow(input = try fly.toInput(from: dictionary))
        XCTAssertEqual(input?.name, "Value")
        XCTAssertEqual(input?.age, 32)
        XCTAssertEqual(input?.value, 100.55)
        XCTAssertNil(input?.additionalInfo)
        XCTAssertEqual(input?.child.count, 2)
        XCTAssertEqual(input?.child[0].name, "Child 1")
        XCTAssertEqual(input?.child[1].name, "Child 2")
        XCTAssertEqual(input?.wife?.name, "Wife")
        XCTAssertEqual(input?.active, true)
    }
    
    func testFlyCodableToOutput() throws {
        let fly = FlyCodableTestModel()
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
                         try fly.toDictionary(from: encodable))
        XCTAssertEqual(dictionary?["name"] as? String, "Value")
        XCTAssertEqual(dictionary?["age"] as? Int, 32)
        XCTAssertEqual(dictionary?["value"] as? Double, 100.55)
        XCTAssertNil(dictionary?["additionalInfo"])
        XCTAssertEqual(dictionary?["child"] as? [[String: String]],
                       [["name": "Child 1"], ["name": "Child 2"]])
        XCTAssertEqual(dictionary?["wife"] as? [String: String], ["name": "Wife"])
        XCTAssertEqual(dictionary?["active"] as? Bool, true)
    }
}
