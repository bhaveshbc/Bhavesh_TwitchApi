//
//  APIManager.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

class APImanager {

    /// router construct request to call http rest API.
    private var router: RouterBuilder

    private var session: URLSession

    /// decoder used to decode response object.
    private var decoder: JSONDecoder

    typealias JSONTaskCompletionHandler<T: Decodable> = (Result<T, APIError>) -> Void

    init(router: RouterBuilder, session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder() ) {
        self.router = router
        self.session = session
        self.decoder = decoder
    }

    /// Call request given  with  api router and decode response
    /// - Parameter completion: clouser that pass decodable object to receiver.
    func fetch<T: Decodable>(completion: @escaping JSONTaskCompletionHandler<T>) {

        var request: URLRequest?

        do {
             request = try router.asURLRequest()
        } catch {
            completion(.failure(APIError.requestNil))
        }

        guard let urlRequest = request else {
            completion(.failure(APIError.requestNil))
            return
        }

        session.dataTask(with: urlRequest) { (data, _, error) in

            guard let data = data else {
                completion(.failure(APIError.requestNil))
                return
            }

            let str = String(decoding: data, as: UTF8.self)
//            print("response data = \(str)")

            if let error = error {
                completion(.failure(APIError.responseError(message: error.localizedDescription)))
                return
            }

            do {
                let responseObject = try self.decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                let userInfo = (error as NSError).userInfo
                print("error \(userInfo)")
                completion(.failure(APIError.responseError(message: "\(userInfo)")))
                return
            }
        }.resume()
    }

}
