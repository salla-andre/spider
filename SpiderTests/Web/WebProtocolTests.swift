//
//  WebProtocolTests.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
import Flies
@testable import Spider

class WebProtocolTests: XCTestCase {

    func testBindFly() throws {
        let web = Web()
        do {
            try web.bind(fly: WebFlyTestModel.self)
            XCTAssert(try web.getFly(for: WebFlyTestModel.path) == WebFlyTestModel.self)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testBindFlyDuplicated() throws {
        let web = Web()
        do {
            try web.bind(fly: WebFlyTestModel.self)
            try web.bind(fly: WebFlyTestModel.self)
        } catch {
            XCTAssertEqual((error as? InternalError), InternalError.duplicatedFly)
        }
    }
    
    func testGetFlyNotBinded() throws {
        let web = Web()
        do {
            let _ = try web.getFly(for: WebFlyTestModel.path)
        } catch {
            XCTAssertEqual((error as? InternalError), InternalError.flyNotFound)
        }
    }
    
    func testValidateDependencies() throws {
        let web = Web()
        do {
            try web.bind(fly: WebFlyTestModel.self)
            try web.bind(fly: WebFlyDependencyTestModel.self)
            XCTAssertNoThrow(try web.validadeDependencies())
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testValidateMissingDependencies() throws {
        let web = Web()
        do {
            try web.bind(fly: WebFlyDependencyTestModel.self)
            XCTAssertThrowsError(try web.validadeDependencies(), "") { error in
                XCTAssertEqual((error as? InternalError),
                               InternalError.missingDependencies)
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}

