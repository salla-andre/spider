//
//  EncodableTestModel.swift
//  FliesTests
//
//  Created by André Salla on 19/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

struct EncodableTestModel: Codable {
    let name: String
    let age: Int
    let value: Double
    let additionalInfo: String?
    let child: [EncodableChildTestModel]
    let wife: EncodableChildTestModel?
    let active: Bool
}
