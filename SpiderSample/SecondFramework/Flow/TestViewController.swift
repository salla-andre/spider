//
//  TestViewController.swift
//  SecondFramework
//
//  Created by Andre Luiz Salla on 17/08/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    weak var selector: UIPickerView?
    
    override func viewDidLoad() {
        self.presentationController?.delegate = self
        createSelector()
    }
    
    private func createSelector() {
        
        let selector = UIPickerView()
        selector.dataSource = self
        selector.delegate = self
        
        
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.addConstraints(
            [NSLayoutConstraint(item: selector,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .notAnAttribute,
                                multiplier: 1,
                                constant: 150)])
        NSLayoutConstraint.activate(selector.constraints)
        
        self.view.addSubview(selector)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            self.view.centerYAnchor.constraint(equalTo: selector.centerYAnchor),
            self.view.centerXAnchor.constraint(equalTo: selector.centerXAnchor),
            self.view.leadingAnchor.constraint(equalTo: selector.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: selector.trailingAnchor)
        ])
        NSLayoutConstraint.activate(self.view.constraints)
        
        self.selector = selector
    }
    
}

extension TestViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return AvailableColors.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if row < AvailableColors.allCases.count {
            return AvailableColors.allCases[row].rawValue
        }
        return nil
    }
    
}

extension TestViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        let selectedRow = selector?.selectedRow(inComponent: 0) ??
            AvailableColors.allCases.count
        if selectedRow < AvailableColors.allCases.count {
            let color = AvailableColors.allCases[selectedRow].color
            MyTestClassSecond.shared.finish(resulting: .success(
                ResultColor.init(backgroundColor: color)))
        } else {
            MyTestClassSecond.shared.finish(resulting: .success(
                ResultColor.init(backgroundColor: "#FFFFFF")))
        }
    }
    
}
