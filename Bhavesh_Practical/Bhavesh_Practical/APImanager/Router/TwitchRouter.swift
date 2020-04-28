//
//  TwitchRouter.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

enum TwitchRouter: RouterBuilder {

    case getUserAuthToken(parameter: UserRequest)
    case getVideoByUser(userId: Int)

    /// indicate HTTP method for request
     var method: HTTPMethod {
        switch self {
        case .getUserAuthToken:
            return .post
        case .getVideoByUser:
            return .get
        }
    }

    /// indicate base Path for request
     var baseUrl: String {
        return APIBaseUrl.development.rawValue
    }

    /// indicate subsequent path for request
     var path: String {
        switch self {
        case .getUserAuthToken :
            return "https://id.twitch.tv/oauth2/token"
        case .getVideoByUser(let userId):
            return "https://api.twitch.tv/helix/videos?user_id=\(userId)"
        }
    }

    /// parameter to send along with request
     var parameter: SSEncodable? {
        switch self {
        case .getUserAuthToken(let model):
            return model
        case .getVideoByUser:
            return nil
        }
    }

    var userToken: String? {
        if let userData = UserDefaults.standard.value(forKey: UserDefaultsKey.userDetail.rawValue) as? Data {
            do {
                let user =  try JSONDecoder().decode(UserModel.self, from: userData)
                return user.accessToken
            } catch let error {
                fatalError("unabel to decode logged User \(error.localizedDescription)")
            }
        }
        return nil
    }

    /// construct URL request from given path, parameter and encoding type
    func asURLRequest() throws ->  URLRequest {

        guard let requestUrl = URL(string: path) else {
            throw APIError.requestNil
        }

        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = method.rawValue
        if let token = self.userToken {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        urlRequest.addValue(AcceptType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        if self.method == .get {
            return urlRequest
        } else {
            guard let parameter = parameter else { throw APIError.parameterEncode }
                urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
                do {
                    let jsonData =   try parameter.toJSONData()
                    if let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        print("parameter = \(jsonDict)")
                    }
                    urlRequest.httpBody = jsonData
                    urlRequest.setValue("\(jsonData.count)", forHTTPHeaderField: HTTPHeaderField.contentLength.rawValue)
                } catch {
                    throw APIError.parameterEncode
                }
            return urlRequest
        }
    }
}
