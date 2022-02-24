//
//  AvailableWindowsGetable.swift
//  Spider
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

protocol AvailableWindowsGetable: AnyObject {
    var windowArray: [WindowProtocol] { get }
}
