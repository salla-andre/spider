//
//  TypeDefs.swift
//  Flies
//
//  Created by André Salla on 12/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation

public typealias BaseType = [String: Any]
public typealias ResultValue<T> = Result<T?, Error>
public typealias CallbackResult<T> = (ResultValue<T>?) -> Void
public typealias BaseCallback = CallbackResult<BaseType>
public typealias BaseResult = ResultValue<BaseType>

