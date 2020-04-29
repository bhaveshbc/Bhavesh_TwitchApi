//
//  CollectionDataProvider.swift
//
//  Created by Bhavesh Chaudhari on 09/10/19.
//  Copyright © 2019 Bhavesh Chaudhari. All rights reserved.
//

import UIKit

public protocol CollectionDataProvider {
    associatedtype Model
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> Model?
    func updateItem(at indexPath: IndexPath, value: Model)
    func removeItem(at indexPath: IndexPath)
}
