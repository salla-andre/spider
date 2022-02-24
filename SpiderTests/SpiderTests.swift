//
//  SpiderTests.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
import Flies
@testable import Spider

class SpiderTests: XCTestCase {

    func testAutomaticBind() throws {
        let bundle = Bundle.allFrameworks.first(where: {
            $0.bundleIdentifier?.contains("BindTestFramework") ?? false})
        let bundlePrincipalClass = bundle?.principalClass as? FlyRegister.Type
        XCTAssertNotNil(bundle)
        XCTAssertNotNil(bundlePrincipalClass)
        XCTAssertNoThrow(try SpiderMain.bind())
        if let web = (SpiderMain.vibration as? Web) {
            let mirror = Mirror(reflecting: web)
            if let registeredFlies = (mirror.children.first(
                where: { $0.label == "flies" })?.value as? [String: FlyBase.Type]) {
                XCTAssertEqual(registeredFlies.count,
                               bundlePrincipalClass?.registrableFlies.count)
            } else {
                XCTFail("Could not find flies property in Web object")
            }
        } else {
            XCTFail("SpiderMain.vibration is not a Web object")
        }
    }
    
    func testManualRegisterAlreadyUpdating() {
        XCTAssertNoThrow(try SpiderMain.startRegister())
        XCTAssertThrowsError(try SpiderMain.startRegister(), "") { error in
            XCTAssertEqual((error as? InternalError), .invalidStateForStartRegister)
        }
    }
    
    func testManualRegisterFinishNotStarted() {
        try? SpiderMain.finishRegister()
        XCTAssertThrowsError(try SpiderMain.finishRegister(), "") { error in
            XCTAssertEqual((error as? InternalError), .invalidStateForFinishRegister)
        }
    }
    
    func testManualRegisterWithoutStart() {
        try? SpiderMain.finishRegister()
        let bundle = Bundle.allFrameworks.first(where: {
            $0.bundleIdentifier?.contains("BindTestFramework") ?? false})
        if let bundlePrincipalClass = bundle?.principalClass as? FlyRegister.Type {
            XCTAssertThrowsError(try SpiderMain.registerFlies(bundlePrincipalClass), "") { error in
                XCTAssertEqual((error as? InternalError), .registerWithoutStart)
            }
        }
    }

}
