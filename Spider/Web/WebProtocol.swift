//
//  WebProtocol.swift
//  Spider
//
//  Created by André Salla on 15/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

protocol WebProtocol {
    
    func bind(fly: FlyBase.Type) throws
    
    func getFly(for path: FlyBase.Path) throws -> FlyBase.Type
    
    func attach(fly: FlyBase,
                callback: BaseCallback?) -> Capsule
    
    func deAttach(capsule: Capsule?)
    
    func validadeDependencies() throws
    
}
