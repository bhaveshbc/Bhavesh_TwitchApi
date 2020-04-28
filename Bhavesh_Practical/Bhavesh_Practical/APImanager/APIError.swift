//
//  APIError.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

enum APIError: Error {

    case parameterEncode
    case requestNil
    case responseDataNil
    case decodableError
    case urlNil
    case responseError(message: String)
    case resultNil
    case tokenNotFound
    case multipartRequestFailed

    /// description for error.
    var errorDescriptions: String {
        switch self {
        case .parameterEncode:
            return "parameter does not encoded successfully."
        case .requestNil:
            return "request creation failed."
        case .responseDataNil:
            return "response data nil."
        case .decodableError:
            return "unable to decode response object."
        case .urlNil:
            return "unable to create url from given path."
        case .resultNil:
            return "return result object is nil"
        case .tokenNotFound:
            return "request Token not found"
        case .multipartRequestFailed:
            return "unable to generate multipart request"
        case .responseError(let message):
            return message
        }
    }
}
