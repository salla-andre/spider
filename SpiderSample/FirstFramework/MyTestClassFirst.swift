//
//  MyTestClassFirst.swift
//  FirstFramework
//
//  Created by Andre Luiz Salla on 14/07/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit
import Flies

public final class MyTestClassFirst: FlyFlow {
        
    let viewController = TestViewController()
    
    public static var path: String {
        return "initial"
    }
    
    public static var dependencies: [DependencyType] {
        return [.required("path/second"),
                .optional("services/network/get")]
    }

    public static func newInstance() -> Self {
        guard let instance = MyTestClassFirst() as? Self else {
            fatalError()
        }
        return instance
    }
    
    public func start(with parameters: BaseType?) throws -> UIViewController {
        let router = Router()
        router.inOutObject = self
        viewController.router = router
        return viewController
    }
    
    private func resume(with result: Result<ColorData?, Error>?) {
        if let result = result {
            switch result {
            case .success(let color):
                if let colorHex = color?.backgroundColor,
                    let uiColor = UIColor(hex: colorHex) {
                    viewController.view.backgroundColor = uiColor
                } else {
                    viewController.view.backgroundColor = .white
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    internal func showMePurple() {
        do {
            if vibration?.isAvailable(signal: "path/second") ?? false {
                try vibration?.flow(signal: "path/second",
                                    parameters: ColorData(backgroundColor: "#0000FF"),
                                    completion: {[weak self] result in
                    self?.resume(with: result)
                })
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    internal func callForData() {
        do {
            if vibration?.isAvailable(signal: "services/network/get") ?? false {
                let urlString = "https://xpto1.free.beeceptor.com/test"
                let callBack: BaseCallback = {[weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            self?.viewController.label?.text =
                                data?["value"] as? String
                        case .failure(_), .none:
                            self?.viewController.label?.text = "Error"
                        }
                    }
                }
                try vibration?.service(signal: "services/network/get",
                                       parameters: ["url" : urlString],
                                       completion: callBack)
            }
        } catch {
            print("Error")
        }
    }

}
