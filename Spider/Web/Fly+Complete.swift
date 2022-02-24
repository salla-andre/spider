//
//  Fly+Complete.swift
//  Spider
//
//  Created by André Salla on 02/12/21.
//  Copyright © 2021 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

fileprivate struct FlyCompletionKeys {
    static var complete: UInt8 = 0
}

internal extension FlyBase {
    
    var completion: BaseCallback? {
        get {
            return objc_getAssociatedObject(self,
                                            &FlyCompletionKeys.complete) as? BaseCallback
        }
        set {
            objc_setAssociatedObject(self,
                                     &FlyCompletionKeys.complete,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

extension FlyBaseFinishable {
    
    @_dynamicReplacement(for: defaultFinish(resulting:for:))
    func finishInSpider(resulting callback: BaseResult?, for fly: FlyBase?) {
        fly?.completion?(callback)
    }
}
