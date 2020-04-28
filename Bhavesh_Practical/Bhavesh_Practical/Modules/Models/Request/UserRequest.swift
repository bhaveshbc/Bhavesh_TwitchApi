//
//  VidioByUserRequest.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

struct UserRequest: SSEncodable {

    let clientId: String
    let clientSecret: String
    let grantType = "client_credentials"

    private enum CodingKeys: String, CodingKey {
        case clientId = "client_id", clientSecret = "client_secret", grantType = "grant_type"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.clientId, forKey: .clientId)
        try container.encode(self.clientSecret, forKey: .clientSecret)
        try container.encode(self.grantType, forKey: .grantType)
    }
}
