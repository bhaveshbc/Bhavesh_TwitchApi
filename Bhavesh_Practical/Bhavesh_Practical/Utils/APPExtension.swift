//
//  APPExtension.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import UIKit

extension UIViewController {

    /// initialise viewController with given frame and view instance.
    /// - Parameter view: object of UIView
    /// - Parameter frame: CGRect that will apply to view frame
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
               view.frame = frame
               let controller = UIViewController()
               controller.view = view
               return controller
           }

    /// used to get viewController storyboard-Id based on viewController type.
    class var storyboardID: String {
        return "\(self)"
    }

    ///initialise ViewController from given Storyboard.
    /// - Parameter appStoryboard: instance of Storyboard
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }

    /// The Function present Alert Controller with given message,Title and clouser.
    /// - Parameter title: title for alert Controller
    /// - Parameter message: message for alert Controller
    /// - Parameter okclick: Clouser for okay button
    func presentAlertMessage(title: String = AlertConstant.alert.localizedString(), message: String, okclick: (() -> Void)? = nil) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: AlertConstant.okay.localizedString(), style: .default) {  _ in
                if okclick != nil {
                    okclick!()
                }
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true) {
            }
        }
}
