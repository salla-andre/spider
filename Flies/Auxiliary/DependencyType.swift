//
//  DependencyType.swift
//  Flies
//
//  Created by André Salla on 03/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

public enum DependencyType {
    case required(FlyBase.Path)
    case optional(FlyBase.Path)
}
