//
//  Web+Vibration.swift
//  Spider
//
//  Created by Andre Luiz Salla on 18/08/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies
import UIKit

extension Web: Vibration {
    
    func isAvailable(signal: FlyBase.Path) -> Bool {
        let fly = try? self.getFly(for: signal)
        return fly != nil
    }
    
    func flow(signal: String,
              style: PresentationType,
              parameters: [String : Any]?,
              completion: BaseCallback?) throws {
        let fly = try getAndCreate(with: signal)
        if let flow = fly as? FlyBaseFlow {
            try checkState(singleton: flow as? FlySingleton)
            let capsule = self.attach(fly: flow, callback: completion)
            flow.completion = capsule.callback
            self.flowFly(to: try flow.start(with: parameters),
                         in: windowsArraySource?.windowArray.filter
                         {$0.isKeyWindow}.first,
                         with: style)
            (flow as? FlySingleton)?.state = .running
        } else {
            throw InternalError.flyIsNotFlow
        }
    }
    
    func flow<T: Codable, U: Codable>(signal: String,
                                      style: PresentationType,
                                      parameters: T?,
                                      completion: CallbackResult<U>?) throws {
        let fly = try getAndCreate(with: signal)
        if let flow = fly as? FlyBaseFlow {
            try checkState(singleton: flow as? FlySingleton)
            let dictionary = try CodableUtils.toDictionary(codable: parameters)
            let callback = self.makeCallback(completion)
            let capsule = self.attach(fly: flow, callback: callback)
            flow.completion = capsule.callback
            self.flowFly(to: try flow.start(with: dictionary),
                         in: windowsArraySource?.windowArray.filter
                         {$0.isKeyWindow}.first,
                         with: style)
            (flow as? FlySingleton)?.state = .running
        } else {
            throw InternalError.flyIsNotFlow
        }
    }
    
    func service(signal: String,
                 parameters: [String : Any]?,
                 completion: BaseCallback?) throws {
        let fly = try getAndCreate(with: signal)
        if let service = fly as? FlyBaseService {
            try checkState(singleton: service as? FlySingleton)
            let capsule = self.attach(fly: service, callback: completion)
            service.completion = capsule.callback
            try service.start(with: parameters)
            (service as? FlySingleton)?.state = .running
        } else {
            throw InternalError.flyIsNotService
        }
    }
    
    func service<T: Codable, U: Codable>(signal: String,
                                         parameters: T?,
                                         completion: CallbackResult<U>?) throws {
        let fly = try getAndCreate(with: signal)
        if let service = fly as? FlyBaseService {
            try checkState(singleton: service as? FlySingleton)
            let dictionary = try CodableUtils.toDictionary(codable: parameters)
            let callback = self.makeCallback(completion)
            let capsule = self.attach(fly: service, callback: callback)
            service.completion = capsule.callback
            try service.start(with: dictionary)
            (service as? FlySingleton)?.state = .running
        } else {
            throw InternalError.flyIsNotService
        }
    }
    
    private func getAndCreate(with signal: String) throws -> FlyBase {
        let flyType = try self.getFly(for: signal)
        let fly = flyType.newInstance()
        return fly
    }
    
    private func checkState(singleton: FlySingleton?) throws {
        if let singleton = singleton,
           singleton.state == .running {
            throw InternalError.singletonIsBusy
        }
    }
    
    private func makeCallback<T: Codable>(_ completion: CallbackResult<T>?) -> BaseCallback? {

        return { result in
            guard let result = result else {
                completion?(nil)
                return
            }
            switch result {
            case .success(let data):
                if let sData = data {
                    if !CodableUtils.checkEncodable(for: sData) {
                        completion?(.failure(InternalError.parserError))
                    } else if let codable: T = try? CodableUtils.toCodable(dictonary: sData) {
                        completion?(.success(codable))
                    } else {
                        completion?(.failure(InternalError.parserError))
                    }
                } else {
                    completion?(.success(nil))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }

    }
}
