//
//  ConfigurableCell.swift
//
//  Created by Bhavesh Chaudhari on 09/10/19.
//  Copyright © 2019 Bhavesh Chaudhari. All rights reserved.
//

import UIKit

public protocol ConfigurableCell: ReusableView {
    associatedtype Model
    func configure(_ item: Model, at indexPath: IndexPath)
}
