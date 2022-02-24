//
//  MyTestClassSecond.swift
//  SecondFramework
//
//  Created by Andre Luiz Salla on 14/07/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies
import UIKit

public final class NetworkService: FlyService {

    public weak var vibration: Vibration?
    
    public static var path: String {
        return "services/network/get"
    }
    
    public static var dependencies: [DependencyType] { [] }
    
    public static func newInstance() -> Self {
        guard let instance = NetworkService() as? Self else {
            fatalError()
        }
        return instance
    }
    
    public func start(with parameters: BaseType?) {
        if let stringUrl = parameters?["url"] as? String,
            let url = URL.init(string: stringUrl) {
            FakeNetworkApi.get(url) {[weak self] (result: Result<TestModel?, Error>) in
                switch result {
                case .success(let model):
                    do {
                        let jsonString = try JSONEncoder().encode(model)
                        let decode = try JSONSerialization.jsonObject(with: jsonString,
                        options: .allowFragments) as? [String: Any]
                        self?.finish(resulting:.success(decode))
                    } catch {
                        self?.finish(resulting: .failure(error))
                    }
                case .failure(let error): self?.finish(resulting: .failure(error))
                }
            }
        } else {
            self.finish(resulting: .failure(NetworkError.invalidParameters))
        }
    }

}
