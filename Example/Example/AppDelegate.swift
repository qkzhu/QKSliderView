//
//  AppDelegate.swift
//  Example
//
//  Created by QianKun on 23/2/19.
//  Copyright © 2019 QianKun. All rights reserved.
//

import UIKit
import FPSLabel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        FPSLabel.install(on: self.window)
        return true
    }
}

