//
//  Spider.swift
//  Spider
//
//  Created by Andre Luiz Salla on 13/07/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Flies
import UIKit

/**
    SpiderMain class is your entry point to Spider Framework.
     
    Calling `bind()`will make Spider to search and bind all your Flies (Flow and Service) together.
    
    After binding all your Flies, you should be able to use `vibration` to call a service or flow.
 
    ~~~
     SpiderMain.bind()
     SpiderMain.vibration.flow("initial")
    ~~~
         
*/
public final class SpiderMain: Main {
    
    typealias WebType = WebProtocol & Vibration & Flyer & Capsulable
    
    internal enum State {
        case created
        case updating
        case ready
    }
    
    internal static var web: WebType = Web()
    private static var state = State.created
    
    /// `vibration` allows you to call a flow or a service anywhere in your code
    public static var vibration: Vibration {
        return web
    }
    
    public static func bind() throws {
        try SpiderMain.startRegister()
        try Bundle.allFrameworks.compactMap{$0.principalClass}.forEach { pClass in
            if let registerClass = pClass as? FlyRegister.Type {
                try SpiderMain.registerFlies(registerClass)
            }
        }
        try SpiderMain.finishRegister()
    }
    
    public static func startRegister() throws {
        guard self.state != .updating else {
            throw InternalError.invalidStateForStartRegister
        }
        self.state = .updating
    }
    
    public static func registerFlies(_ flyRegister: FlyRegister.Type) throws {
        guard self.state == .updating else {
            throw InternalError.registerWithoutStart
        }
        try flyRegister.registrableFlies.forEach { (item) throws in
            if let flyClass = item as? FlyBaseFlow.Type {
                try self.web.bind(fly: flyClass)
            } else if let flyClass = item as? FlyBaseService.Type {
                try self.web.bind(fly: flyClass)
            }
        }
    }
    
    public static func finishRegister() throws {
        guard self.state == .updating else {
            throw InternalError.invalidStateForFinishRegister
        }
        try web.validadeDependencies()
        self.state = .ready
    }
    
}
