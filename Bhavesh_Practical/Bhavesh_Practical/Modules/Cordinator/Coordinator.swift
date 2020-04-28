//
//  Coordinator.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
}
