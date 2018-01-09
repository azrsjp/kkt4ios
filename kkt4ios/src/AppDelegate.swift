//
//  AppDelegate.swift
//  kkt4ios
//
//  Created by tt on 2018/01/02.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import UIKit
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = LoginViewController()
        self.window?.makeKeyAndVisible()

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        print(url)
        if let host = url.host, host == Config.Scheme.login {
            OAuthSwift.handle(url: url)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

