//
//  AppDelegate.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 03/12/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationViewController = UINavigationController()
        let userListViewController = MainViewController()
        navigationViewController.viewControllers = [userListViewController]
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationViewController
        return true
    }
}
