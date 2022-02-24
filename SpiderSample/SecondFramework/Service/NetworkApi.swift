//
//  NetworkApi.swift
//  SecondFramework
//
//  Created by Andre Luiz Salla on 08/12/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation

class FakeNetworkApi {
    
    static func get<T: Codable>(_ url: URL, completion: @escaping (Result<T?, Error>)->Void) {
        DispatchQueue.global().async {
            if url.absoluteString == "https://xpto1.free.beeceptor.com/test",
            T.self == TestModel.self {
                completion(.success(TestModel(value: "Hello World") as? T))
            } else {
                completion(.failure(NetworkError.genericError))
            }
        }
    }
    
}
