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

class CapsuleTests: XCTestCase {

    func testCallBackCalledBeforeSetDoesNothing() throws {
        let web = WebCapsuleTest()
        let capsule = Capsule(fly: FlyCapsuleTestModel())
        capsule.web = web
        
        capsule.callback?(.success(nil))
        
        XCTAssert(capsule.callback != nil)
        XCTAssert(!web.detachedCalled)
    }
    
    func testCapsuleWithCallbackSet() throws {
        let web = WebCapsuleTest()
        let capsule = Capsule(fly: FlyCapsuleTestModel())
        capsule.web = web
        var callBackCalled = false
        capsule.callback?(.success(nil))
        let callback: BaseCallback = { _ in
            callBackCalled = true
        }
        capsule.set(callback: callback)
        XCTAssert(capsule.callback != nil)
        capsule.callback?(.success(nil))
        XCTAssert(callBackCalled)
        XCTAssert(web.detachedCalled)
    }
    
    func testCapsuleHashable() throws {
        let capsule1 = Capsule(fly: FlyCapsuleTestModel())
        let capsule2 = Capsule(fly: FlyCapsuleTestModel())
        var setCapsule = Set<Capsule>()
        XCTAssert(setCapsule.insert(capsule1).inserted)
        XCTAssert(setCapsule.insert(capsule2).inserted)
        XCTAssert(!setCapsule.insert(capsule1).inserted)
    }

    
    
}

