//
//  CapsuleTests.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
import Flies
@testable import Spider

class FlySingletonStateTests: XCTestCase {

    func testIdleStateAfterCreate() throws {
        let dummy = DummySingletonFly()
        XCTAssert(dummy.state == .idle)
    }
    
    func testStateChange() throws {
        let dummy = DummySingletonFly()
        dummy.state = .running
        XCTAssert(dummy.state == .running)
    }
    
}

