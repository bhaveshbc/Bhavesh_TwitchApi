//
//  AppDelegate.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RootViewControllerProvider {

    var window: UIWindow?
    var coordinator: Coordinator?

    static var standard: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13.0, *) { } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            setupRootViewController(with: window!)
        }
        return true
    }
}

protocol RootViewControllerProvider: class {

    var coordinator: Coordinator? { get set }
    func setupRootViewController( with window: UIWindow)
}

extension RootViewControllerProvider {
    func setupRootViewController( with window: UIWindow) {
        let dashBoardNavigation = UINavigationController()
        dashBoardNavigation.navigationBar.isHidden = true
        coordinator = DashboardCoordinator()
        coordinator?.start()
        window.rootViewController = coordinator?.navigationController
        window.makeKeyAndVisible()
    }
}
