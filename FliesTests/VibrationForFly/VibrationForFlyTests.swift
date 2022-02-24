//
//  VibrationForFlyTests.swift
//  FliesTests
//
//  Created by André Salla on 20/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
@testable import Flies
import Spider

class VibrationForFlyTests: XCTestCase {

    func testVibrationMissingDependencies() throws {
        guard let vibration = VibrationForFly(vibration: SpiderMain.vibration,
                                              source: FlyBaseTestModel()) else {
            XCTFail("Create VibrationForFly failed")
            return
        }
        XCTAssertFalse(vibration.isAvailable(signal: "missingDependency"))
        XCTAssertThrowsError(try vibration.service(signal: "missingDependency", parameters: nil, completion: nil), "") { error in
            XCTAssertEqual(error as? InternalError, .callingMissingDependency)
        }
        XCTAssertThrowsError(try vibration.flow(signal: "missingDependency", style: .present, parameters: nil, completion: nil), "") { error in
            XCTAssertEqual(error as? InternalError, .callingMissingDependency)
        }
        XCTAssertThrowsError(try vibration.flow(signal: "missingDependency", style: .present, parameters: Empty(), completion: nil as CallbackResult<Empty>?), "") { error in
            XCTAssertEqual(error as? InternalError, .callingMissingDependency)
        }
        XCTAssertThrowsError(try vibration.service(signal: "missingDependency", parameters: Empty(), completion: nil as CallbackResult<Empty>?), "") { error in
            XCTAssertEqual(error as? InternalError, .callingMissingDependency)
        }
        
    }

    func testVibrationNilInit() throws {
        XCTAssertNil(VibrationForFly(vibration: nil, source: nil))
        XCTAssertNil(VibrationForFly(vibration: SpiderMain.vibration, source: nil))
        XCTAssertNil(VibrationForFly(vibration: nil, source: FlyBaseTestModel()))
    }
    
    func testVibrationFlow() throws {
        let fly = VibrationForFlyDependencyFlowModel()
        guard let vibration = VibrationForFly(vibration: SpiderMain.vibration,
                                              source: fly) else {
            XCTFail("Create VibrationForFly failed")
            return
        }
        try SpiderMain.startRegister()
        try SpiderMain.registerFlies(RegisterDependenciesTest.self)
        try SpiderMain.finishRegister()
        
        XCTAssertNoThrow(try vibration.service(signal: "flyTests/serviceTests", parameters: nil, completion: nil))
        XCTAssertNoThrow(try vibration.flow(signal: "flyTests/flowTests", parameters: nil, completion: nil))
        XCTAssertNoThrow(try vibration.flow(signal: "flyTests/flowTests", parameters: Empty(), completion: nil as CallbackResult<Empty>?))
        XCTAssertNoThrow(try vibration.service(signal: "flyTests/serviceTests", parameters: Empty(), completion: nil as CallbackResult<Empty>?))
        
    }
}
