//
//  Router.swift
//  FirstFramework
//
//  Created by Andre Luiz Salla on 18/08/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation

class Router {
    weak var inOutObject: MyTestClassFirst?
    
    func showMePurple() {
        inOutObject?.showMePurple()
    }
    
    func callForData() {
        inOutObject?.callForData()
    }
}
