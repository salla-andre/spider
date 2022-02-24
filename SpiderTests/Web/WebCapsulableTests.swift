//
//  WebCapsulableTests.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
import Flies
@testable import Spider

class WebCapsulableTests: XCTestCase {

    func testAttachFly() throws {
        let web = Web()
        let fly = WebFlyTestModel.newInstance()
        let capsule = web.attach(fly: fly, callback: nil)
        XCTAssert(getCapsuleArray(in: web)?.contains(capsule) ?? false)
    }
    
    func testDeAttachFly() throws {
        let web = Web()
        let fly = WebFlyTestModel.newInstance()
        let capsule = web.attach(fly: fly, callback: nil)
        XCTAssert(getCapsuleArray(in: web)?.contains(capsule) ?? false)
        web.deAttach(capsule: capsule)
        if let array = getCapsuleArray(in: web) {
            XCTAssertFalse(array.contains(capsule))
        } else {
            XCTFail("Capsules array unavailable")
        }
    }
    
    private func getCapsuleArray(in web: Web) -> Set<Capsule>? {
        let mirror = Mirror(reflecting: web)
        if let capsules = mirror.children.first(where: { $0.label == "web" })?.value as? Set<Capsule> {
            return capsules
        } else {
            XCTFail("Capsules array unavailable")
        }
        return nil
    }
    
}


