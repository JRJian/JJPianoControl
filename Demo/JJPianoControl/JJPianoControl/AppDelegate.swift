//
//  AppDelegate.swift
//  JJPianoControl
//
//  Created by chenjiantao on 15/12/31.
//  Copyright © 2015年 chenjiantao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.backgroundColor = UIColor(red: 84/255, green: 148/255, blue: 205/255, alpha: 1)
        window!.rootViewController = ViewController()
        window!.makeKeyAndVisible()
        
        return true
    }

}

