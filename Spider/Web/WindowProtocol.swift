//
//  WindowProtocol.swift
//  Spider
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

protocol WindowProtocol: AnyObject {
    var rootViewController: UIViewController? { get set }
    var isKeyWindow: Bool { get }
    func makeKeyAndVisible()
}

extension UIWindow: WindowProtocol { }
