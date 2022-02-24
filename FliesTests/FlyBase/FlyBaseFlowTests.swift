//
//  FlyBaseFlowTests.swift
//  FliesTests
//
//  Created by André Salla on 17/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
@testable import Flies

class FlyBaseFlowTests: XCTestCase {

    func testStartCallWithNilParameter() throws {
        let fly = FlyBaseFlowTestModel()
        fly.startClosure = { result in
            if case let .success(parameter) = result {
                XCTAssertNil(parameter)
            } else {
                XCTFail("Invalid return")
            }
        }
        XCTAssertNoThrow(try fly.start())
    }

}
