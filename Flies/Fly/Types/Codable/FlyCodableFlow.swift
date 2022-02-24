//
//  FlyCodableFlow.swift
//  Flies
//
//  Created by André Salla on 12/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

public protocol FlyCodableFlow: FlyTypedFlow, FlyCodable where Self.Input == Self.Parameter { }
