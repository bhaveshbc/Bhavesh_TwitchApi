//
//  RouterBuilder.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

protocol RouterBuilder {
    var method: HTTPMethod {get}
    var baseUrl: String {get}
    var path: String {get}
    var parameter: SSEncodable? {get}
    func asURLRequest() throws ->  URLRequest
}

protocol SSEncodable: Encodable {
    func toJSONData() throws ->  Data
}

extension SSEncodable {
    func toJSONData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

typealias ResponseType<T> = (Result<T, APIError>) -> Void
