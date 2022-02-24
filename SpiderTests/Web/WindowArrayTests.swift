//
//  WindowArrayTests.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
import Flies
@testable import Spider

class WindowArrayTests: XCTestCase {
    
    func testBindFly() throws {
        let web = Web()
        XCTAssertEqual(web.windowsArraySource?.windowArray.count, 0)
    }
}
