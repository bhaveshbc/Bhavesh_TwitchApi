//
//  User.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    let accessToken: String
    let expireIn: Int
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expireIn = "expires_in"
        case tokenType = "token_type"
    }

    init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
          accessToken = try values.decode(String.self, forKey: .accessToken)
          expireIn = try values.decode(Int.self, forKey: .expireIn)
          tokenType = try values.decode(String.self, forKey: .tokenType)
      }
}
