//
//  AppConstant.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

enum TwitchConstant: String {
    case clientID = "jpgequam6ev2l6jdssn37dduuv02lc"
    case clientSecrete = "46zu054ke58o81txe38bntxg42g77q"
}

enum UserDefaultsKey: String {
    case userDetail
}

enum AlertConstant: String {
    case okay = "OK"
    case alert = "Alert"

    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
