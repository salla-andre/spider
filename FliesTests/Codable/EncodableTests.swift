//
//  EncodableTests.swift
//  FliesTests
//
//  Created by André Salla on 19/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

@testable import Flies
import XCTest

class EncodableTests: XCTestCase {

    func testEncodable() throws {
        let encodable = EncodableTestModel(name: "Value",
                                           age: 32,
                                           value: 100.55,
                                           additionalInfo: nil,
                                           child: [EncodableChildTestModel(name: "Child 1"),
                                                   EncodableChildTestModel(name: "Child 2")],
                                           wife: EncodableChildTestModel(name: "Wife"),
                                           active: true)
        var dictionary: [String: Any]? = nil
        XCTAssertNoThrow(dictionary = try encodable.toDictionary())
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
