//
//  FlyCompletionTests.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
import Flies
@testable import Spider

class FlyCompletionTests: XCTestCase {

    func testCompletion() throws {
        let flyTest = FlyCompletionTestModel.newInstance()
        var completionCalled = false
        flyTest.completion = { _ in
            completionCalled = true
        }
        flyTest.completion?(.success(nil))
        XCTAssert(completionCalled)
    }
    
    func testFinishable() throws {
        let flyTest = FlyCompletionTestModel.newInstance()
        var completionCalled = false
        flyTest.completion = { _ in
            completionCalled = true
        }
        flyTest.finish(resulting: .success(nil))
        XCTAssert(completionCalled)
    }
    
}
