//
//  WebVibrationTests.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
import Flies
@testable import Spider

class WebVibrationTests: XCTestCase {

    var web: Web = Web()
    
    override func setUpWithError() throws {
        self.web = Web()
        let windowSourcer = WindowSourcer()
        let window = DummyWindowModel()
        window.makeKeyAndVisible()
        windowSourcer.windowArray.append(window)
        self.web.windowsArraySource = windowSourcer
    }
    
    func testIsAvailableWithAvailableFly() throws {
        do {
            try web.bind(fly: WebFlyTestModel.self)
            XCTAssert(web.isAvailable(signal: WebFlyTestModel.path))
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testIsAvailableWithUnavailableFly() throws {
        XCTAssert(!web.isAvailable(signal: WebFlyTestModel.path))
    }
    
    func testCallAvailableFlowWithBaseParameters() throws {
        do {
            try web.bind(fly: WebFlyFlowTestModel.self)
            XCTAssert(web.isAvailable(signal: WebFlyFlowTestModel.path))
            try web.flow(signal: WebFlyFlowTestModel.path,
                     style: .present,
                     parameters: nil,
                     completion: createCallback())
            let fly: WebFlyFlowTestModel? = getAttachedFly(in: web)
            XCTAssert(fly?.startIsCalled ?? false)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testCallAvailableFlowWithCodableParameters() throws {
        do {
            try web.bind(fly: WebFlyFlowTestModel.self)
            XCTAssert(web.isAvailable(signal: WebFlyFlowTestModel.path))
            let callback: CallbackResult<DumyCodable> = createCallback()
            try web.flow(signal: WebFlyFlowTestModel.path,
                         style: .present,
                         parameters: DumyCodable(startCalled: false),
                         completion: callback)
            let fly: WebFlyFlowTestModel? = getAttachedFly(in: web)
            XCTAssert(fly?.startIsCalled ?? false)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testCallBaseFlowWithServicePath() throws {
        do {
            try web.bind(fly: WebFlyFlowTestModel.self)
            try web.bind(fly: WebFlyServiceTestModel.self)
            XCTAssertThrowsError(try web.flow(signal: WebFlyServiceTestModel.path,
                                              style: .present,
                                              parameters: nil,
                                              completion: { _ in }), "") { error in
                XCTAssert((error as? InternalError) == .flyIsNotFlow)
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCallCodableFlowWithServicePath() throws {
        do {
            try web.bind(fly: WebFlyFlowTestModel.self)
            try web.bind(fly: WebFlyServiceTestModel.self)
            let callback: CallbackResult<DumyCodable> = createCallback()
            XCTAssertThrowsError(try web.flow(signal: WebFlyServiceTestModel.path,
                                              style: .present,
                                              parameters: DumyCodable(startCalled: false),
                                              completion: callback), "", { error in
                XCTAssert((error as? InternalError) == .flyIsNotFlow)
            })
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCallBaseServiceWithFlowPath() throws {
        do {
            try web.bind(fly: WebFlyFlowTestModel.self)
            try web.bind(fly: WebFlyServiceTestModel.self)
            XCTAssertThrowsError(try web.service(signal: WebFlyFlowTestModel.path,
                                                 parameters: nil,
                                                 completion: { _ in }), "") { error in
                XCTAssert((error as? InternalError) == .flyIsNotService)
            }
            
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCallCodableServiceWithServicePath() throws {
        do {
            try web.bind(fly: WebFlyFlowTestModel.self)
            try web.bind(fly: WebFlyServiceTestModel.self)
            let callback: CallbackResult<DumyCodable> = createCallback()
            XCTAssertThrowsError(try web.service(signal: WebFlyFlowTestModel.path,
                                              parameters: DumyCodable(startCalled: false),
                                              completion: callback), "", { error in
                XCTAssert((error as? InternalError) == .flyIsNotService)
            })
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCallAvailableServiceWithBaseParameters() throws {
        do {
            try web.bind(fly: WebFlyServiceTestModel.self)
            XCTAssert(web.isAvailable(signal: WebFlyServiceTestModel.path))
            try web.service(signal: WebFlyServiceTestModel.path,
                            parameters: nil,
                            completion: createCallback())
            let fly: WebFlyServiceTestModel? = getAttachedFly(in: web)
            XCTAssert(fly?.startIsCalled ?? false)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testCallAvailableServiceWithCodableParameters() throws {
        do {
            try web.bind(fly: WebFlyServiceTestModel.self)
            XCTAssert(web.isAvailable(signal: WebFlyServiceTestModel.path))
            let callback: CallbackResult<DumyCodable> = createCallback()
            try web.service(signal: WebFlyServiceTestModel.path,
                            parameters: DumyCodable(startCalled: false),
                            completion: callback)
            let fly: WebFlyServiceTestModel? = getAttachedFly(in: web)
            XCTAssert(fly?.startIsCalled ?? false)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCallbackFromCodableToParametersNilResult() throws {
        checkCallback(resulting: nil) { result in
            XCTAssertNil(result)
        }
    }
    
    func testCallbackFromCodableToParametersSuccessNil() throws {
        checkCallback(resulting: .success(nil)) { result in
            XCTAssertNotNil(result)
            if case let .success(value) = result {
                XCTAssertNil(value)
            } else {
                XCTFail("Invalid return")
            }
        }
    }
    
    func testCallbackFromCodableToParametersSuccessNotCodable() throws {
        checkCallback(resulting: .success(["startCalled": UIView()])) { result in
            XCTAssertNotNil(result)
            if case let .failure(error) = result {
                XCTAssertEqual((error as? InternalError), .parserError)
            } else {
                XCTFail("Invalid Codable not failed")
            }
        }
    }
    
    func testCallbackFromCodableToParametersError() throws {
        checkCallback(resulting: .failure(InternalError.missingDependencies)) { result in
            XCTAssertNotNil(result)
            if case let .failure(error) = result {
                XCTAssertEqual((error as? InternalError), .missingDependencies)
            } else {
                XCTFail("Failed Result not failed")
            }
        }
    }
    
    func testCallbackFromCodableToParametersSuccessValue() throws {
        checkCallback(resulting: .success(["startCalled": true])) { result in
            XCTAssertNotNil(result)
            if case let .success(dummy) = result {
                XCTAssertNotNil(dummy)
                XCTAssert(dummy?.startCalled ?? false)
            } else {
                XCTFail("Invalid return")
            }
        }
    }
    
    func testCallAvailableServiceBusySingleton() throws {
        do {
            try web.bind(fly: WebFlySingletonTestModel.self)
            XCTAssert(web.isAvailable(signal: WebFlySingletonTestModel.path))
            let callback: CallbackResult<DumyCodable> = createCallback()
            XCTAssertNoThrow(
                try web.service(signal: WebFlySingletonTestModel.path,
                                parameters: DumyCodable(startCalled: false),
                                completion: callback))
            let fly: WebFlySingletonTestModel? = getAttachedFly(in: web)
            XCTAssert(fly?.startIsCalled ?? false)
            XCTAssertEqual(fly?.state, .running)
            XCTAssertThrowsError(
                try web.service(signal: WebFlySingletonTestModel.path,
                                parameters: DumyCodable(startCalled: false),
                                completion: callback), "", { error in
                XCTAssertEqual((error as? InternalError), .singletonIsBusy)
            })
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    private func checkCallback(resulting result: BaseResult?,
                               with callback: @escaping CallbackResult<DumyCodable>) {
        do {
            try web.bind(fly: WebFlyServiceTestModel.self)
            XCTAssert(web.isAvailable(signal: WebFlyServiceTestModel.path))
            let callback: CallbackResult<DumyCodable> = callback
            try web.service(signal: WebFlyServiceTestModel.path,
                            parameters: DumyCodable(startCalled: false),
                            completion: callback)
            let fly: WebFlyServiceTestModel? = getAttachedFly(in: web)
            fly?.finish(resulting: result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    private func getAttachedFly<T: FlyBase>(in web: Web) -> T? {
        let mirror = Mirror(reflecting: web)
        if let capsules = mirror.children.first(where: { $0.label == "web" })?.value as? Set<Capsule> {
            if let testFly = capsules.first?.fly as? T {
                return testFly
            } else {
                XCTFail("Fly not of type \(T.self)")
            }
        } else {
            XCTFail("Capsules unavailable")
        }
        return nil
    }
    
    private func createCallback<T>() -> CallbackResult<T> {
        return { result in
            if let result = result {
                switch result {
                case .success(let values):
                    if let values = values as? [String: Any] {
                        XCTAssert(values["startCalled"] as? Bool ?? false)
                    } else if let values = values as? Codable {
                        let mirror = Mirror(reflecting: values)
                        XCTAssert(mirror.children
                            .filter{ $0.label == "startCalled" }
                            .first?.value as? Bool ?? false)
                    }
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } else {
                XCTFail("Nil result")
            }
        }
    }
    
}

