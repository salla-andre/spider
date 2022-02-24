//
//  Capsule.swift
//  Spider
//
//  Created by Andre Luiz Salla on 08/12/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies

class Capsule: Hashable, Equatable {
    
    let uuid: UUID
    let fly: FlyBase
    var web: Capsulable?
    private(set) var callback: BaseCallback?
    
    init(fly: FlyBase) {
        uuid = UUID()
        self.fly = fly
        self.callback = { _ in }
    }
    
    func set(callback: BaseCallback?) {
        let wrappCallback: BaseCallback = { [weak self] result in
            self?.fly.completion = nil
            (self?.fly as? FlySingleton)?.state = .idle
            callback?(result)
            self?.web?.deAttach(capsule: self)
        }
        self.callback = wrappCallback
    }

    static func == (lhs: Capsule, rhs: Capsule) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.uuid)
    }
}
