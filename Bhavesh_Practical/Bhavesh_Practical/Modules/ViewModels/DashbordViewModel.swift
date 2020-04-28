//
//  DashBoardViewModel.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

class DashBoardViewModel {

    var modelList: [VideoViewModel] = []

    func getUserToken(with request: UserRequest, then handler: @escaping ResponseType<UserModel>) {
        let router = TwitchRouter.getUserAuthToken(parameter: request)
        let apimanager = APImanager.init(router: router)
        apimanager.fetch { (response: Result<UserModel, APIError>) in
            switch response {
            case .success(let responseObject):
                handler(.success(responseObject))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }

    func saveLoggedUserToUserDefault(defaults: UserDefaults = .standard, encoder: JSONEncoder = JSONEncoder(), user: UserModel) throws {
        do {
            let encoded = try encoder.encode(user)
            defaults.set(encoded, forKey: UserDefaultsKey.userDetail.rawValue)
        } catch {
            throw error
        }
    }

    func getVideos(by userId: Int, then handler: @escaping ResponseType<[VideoViewModel]>) {
        let router = TwitchRouter.getVideoByUser(userId: userId)
        let apimanager = APImanager.init(router: router)
        apimanager.fetch { (response: Result<VideoList, APIError>) in
            switch response {
            case .success(let responseObject):
                self.modelList = responseObject.videoList.map { VideoViewModel(video: $0) }
                handler(.success(self.modelList))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }

    func viewModel(at index: Int) -> VideoViewModel? {
           guard index >= 0 && index < modelList.count else { return nil }
           return modelList[index]
    }

    var modelListCount: Int {
        return modelList.count
    }

}
