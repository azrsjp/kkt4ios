//
//  AppDelegate.swift
//  kkt4ios
//
//  Created by tt on 2018/01/02.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import OAuthSwift
import SwiftyUserDefaults
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = firstViewController()
        window?.makeKeyAndVisible()

        return true
    }

    func application(_: UIApplication, open url: URL, options _: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        print(url)
        if let host = url.host, host == Config.Scheme.login {
            OAuthSwift.handle(url: url)
        }
        return true
    }

    func applicationWillResignActive(_: UIApplication) {
    }

    func applicationDidEnterBackground(_: UIApplication) {
    }

    func applicationWillEnterForeground(_: UIApplication) {
    }

    func applicationDidBecomeActive(_: UIApplication) {
    }

    func applicationWillTerminate(_: UIApplication) {
    }

    // MARK: - private

    private func firstViewController() -> UIViewController {
        let isAuthorized = Defaults[.accessToken] != nil

        return isAuthorized ? HomeViewController.withDrawer() : LoginViewController()
    }
}
