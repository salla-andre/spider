//
//  FlyFinishableTests.swift
//  FliesTests
//
//  Created by André Salla on 21/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
@testable import Flies
import Spider

class FlyFinishableTests: XCTestCase {

    func testFlyFinishable() throws {
        let fly = FlyFinishableTestModel.newInstance()
        try? SpiderMain.startRegister()
        try? SpiderMain.registerFlies(FlyFinishableTestRegister.self)
        try? SpiderMain.finishRegister()
        XCTAssertNoThrow(try successCase(with: fly))
        XCTAssertNoThrow(try failureCase(with: fly))
        XCTAssertNoThrow(try nilCase(with: fly))
        XCTAssertNoThrow(try failureCaseFromDecoding(with: fly))
    }
    
    func successCase(with fly: FlyFinishableTestModel) throws {
        let encodable = EncodableTestModel(name: "Value",
                                           age: 32,
                                           value: 100.55,
                                           additionalInfo: nil,
                                           child: [EncodableChildTestModel(name: "Child 1"),
                                                   EncodableChildTestModel(name: "Child 2")],
                                           wife: EncodableChildTestModel(name: "Wife"),
                                           active: true)
        let callback: CallbackResult<EncodableTestModel>? = { result in
            XCTAssertNotNil(result)
            if case let .success(value) = result {
                XCTAssertNotNil(value)
                XCTAssertEqual(encodable.name, value?.name)
                XCTAssertEqual(encodable.age, value?.age)
                XCTAssertEqual(encodable.additionalInfo,
                               value?.additionalInfo)
                XCTAssertEqual(encodable.value, value?.value)
                XCTAssertEqual(encodable.child.count, value?.child.count)
                XCTAssertEqual(encodable.child[0].name,
                               value?.child[0].name)
                XCTAssertEqual(encodable.child[1].name,
                               value?.child[1].name)
                XCTAssertEqual(encodable.wife?.name, value?.wife?.name)
                XCTAssertEqual(encodable.active, value?.active)
            } else {
                XCTFail("Unexpected result")
            }
        }
        try SpiderMain.vibration.service(signal: FlyFinishableTestModel.path,
                                         parameters: nil as EncodableTestModel?,
                                         completion: callback)
        fly.finish(resulting: .success(encodable))
    }
    
    func failureCase(with fly: FlyFinishableTestModel) throws {
        let callback: CallbackResult<EncodableTestModel>? = { result in
            XCTAssertNotNil(result)
            if case let .failure(error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error as? InternalError, .invalidParameters(origin: NSError.init(domain: "", code: 1, userInfo: nil)))
            } else {
                XCTFail("Unexpected result")
            }
        }
        try SpiderMain.vibration.service(signal: FlyFinishableTestModel.path,
                                         parameters: nil as EncodableTestModel?,
                                         completion: callback)
        fly.finish(resulting: .failure(InternalError.invalidParameters(origin: NSError.init(domain: "", code: 1, userInfo: nil))))
    }
    
    func failureCaseFromDecoding(with fly: FlyFinishableTestModel) throws {
        let encodable = EncodableTestModel(name: "Value",
                                           age: 32,
                                           value: 100.55,
                                           additionalInfo: nil,
                                           child: [EncodableChildTestModel(name: "Child 1"),
                                                   EncodableChildTestModel(name: "Child 2")],
                                           wife: EncodableChildTestModel(name: "Wife"),
                                           active: true)
        fly.shouldSucceedToDictionary = false
        let callback: CallbackResult<EncodableTestModel>? = { result in
            XCTAssertNotNil(result)
            if case let .failure(error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error as? InternalError, .parserError)
            } else {
                XCTFail("Unexpected result")
            }
        }
        try SpiderMain.vibration.service(signal: FlyFinishableTestModel.path,
                                         parameters: nil as EncodableTestModel?,
                                         completion: callback)
        fly.finish(resulting: .success(encodable))
    }
    
    func nilCase(with fly: FlyFinishableTestModel) throws {
        let callback: CallbackResult<EncodableTestModel>? = { result in
            XCTAssertNil(result)
        }
        try SpiderMain.vibration.service(signal: FlyFinishableTestModel.path,
                                         parameters: nil as EncodableTestModel?,
                                         completion: callback)
        fly.finish(resulting: nil)
    }

}
