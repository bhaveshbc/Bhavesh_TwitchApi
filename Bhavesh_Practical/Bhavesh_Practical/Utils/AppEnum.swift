//
//  AppEnum.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import UIKit

enum AppStoryboard: String {

    case main = "Main"

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    /// The Function used to initialise ViewController from storyboard.
    /// - Parameter viewControllerClass: ViewController type.
    /// - Parameter function: indicate function to log while fatalError
    /// - Parameter line: line number for log
    /// - Parameter file: file used for log in Fatal error.
    func viewController<T: UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {

        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID

        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {

            fatalError("""
                ViewController with identifier \(storyboardID),
                not found in \(self.rawValue) Storyboard.
                \nFile : \(file) \nLine Number : \(line) \nFunction : \(function)
                """)
        }

        return scene
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
