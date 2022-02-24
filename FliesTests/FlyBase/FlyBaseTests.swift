//
//  FlyBaseTests.swift
//  FliesTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
@testable import Flies

class FlyBaseTests: XCTestCase {

    func testVibration() throws {
        let fly = FlyBaseTestModel()
        XCTAssertNotNil(fly.vibration)
    }

}
