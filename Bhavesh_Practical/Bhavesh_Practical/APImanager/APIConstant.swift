//
//  APIConstant.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

/// enum for Rest APi HTTP method constant
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

/// enum for Request  Content Type constant
enum ContentType: String {
    case json = "application/json"
}

enum AcceptType: String {
    case json = "application/json"
}

/// enum for HTTP header Filed constant
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case contentLength = "Content-Length"
}

/// enum for base URl constant
enum APIBaseUrl: String {
    case development = "http://short.weblook.xyz/api/"
    case distribution = "http://short.weblook.xyz/distribution/api/"
}
