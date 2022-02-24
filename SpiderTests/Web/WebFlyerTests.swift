//
//  WebFlyerTests.swift
//  SpiderTests
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import XCTest
import UIKit
@testable import Spider

class WebFlyerTests: XCTestCase {
    
    func testFlyWithNoRootViewController() throws {
        let web = Web()
        let window = DummyWindowModel()
        let presenting = DummyViewController()
        web.flowFly(to: presenting,
                    in: window,
                    with: .present)
        XCTAssert(window.rootViewController === presenting)
    }
    
    func testFlyWithSingleViewController() throws {
        let web = Web()
        let window = DummyWindowModel()
        let topVc = DummyViewController()
        window.rootViewController = topVc
        let presenting = DummyViewController()
        web.flowFly(to: presenting,
                    in: window,
                    with: .present)
        XCTAssert(topVc.internalPresentedViewController === presenting)
    }
    
    func testFlyWithMultipleViewController() throws {
        let web = Web()
        let window = DummyWindowModel()
        window.rootViewController = DummyViewController()
        let topVc = DummyViewController()
        window.rootViewController?.present(topVc,
                                           animated: true, completion: nil)
        let presenting = DummyViewController()
        web.flowFly(to: presenting,
                    in: window,
                    with: .present)
        XCTAssert(topVc.internalPresentedViewController === presenting)
    }
    
    func testFlyWithNavigationViewController() throws {
        let web = Web()
        let window = DummyWindowModel()
        let navigation = DummyNavigationViewController(
            rootViewController: DummyViewController())
        let pushedViewController = DummyViewController()
        window.rootViewController = navigation
        web.flowFly(to: pushedViewController,
                    in: window,
                    with: .push)
        XCTAssert(navigation.lastPushedViewController === pushedViewController)
    }
    
}
