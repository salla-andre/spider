//
//  Web+Window.swift
//  Spider
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

extension Web: AvailableWindowsGetable {
    var windowArray: [WindowProtocol] {
        return UIApplication.shared.windows
    }
}
