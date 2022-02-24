//
//  TestViewController.swift
//  FirstFramework
//
//  Created by Andre Luiz Salla on 17/08/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    var router: Router?
    weak var label: UILabel?
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .green
        
        let buttonFlow = UIButton(frame:
            CGRect.init(x: 0, y: 60, width: 200, height: 50))
        buttonFlow.setTitle("Click me for flow", for: .normal)
        buttonFlow.addTarget(self, action: #selector(testFlow), for: .touchUpInside)
        
        self.view.addSubview(buttonFlow)
        
        let buttonService = UIButton(frame:
            CGRect.init(x: 0, y: 120, width: 200, height: 50))
        buttonService.setTitle("Click me for service", for: .normal)
        buttonService.addTarget(self, action: #selector(testService), for: .touchUpInside)
        
        self.view.addSubview(buttonService)
        
        let labelService = UILabel(frame:
            CGRect.init(x: 0, y: 170, width: 200, height: 50))
        labelService.text = ""
        label = labelService
        
        self.view.addSubview(labelService)
    }
    
    @objc func testFlow() {
        router?.showMePurple()
    }
    
    @objc func testService() {
        router?.callForData()
    }
}
