//
//  Flyer.swift
//  Spider
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit
import Flies

protocol Flyer {
    func flowFly(to viewController: UIViewController,
                 in window: WindowProtocol?,
                 with type: PresentationType)
}
