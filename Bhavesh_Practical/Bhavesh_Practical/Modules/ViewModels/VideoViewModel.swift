//
//  VideoViewModel.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

protocol  VideoViewModelProtocol {
    var video: Video { get set }
    var viewCounts: String { get }
    var videoId: String { get }
    func getThumbUrl(with size: (Int, Int)) -> URL?
    func downloadThumb(with size: (Int, Int), then handler: @escaping (Data?) -> Void)
}

struct VideoViewModel: VideoViewModelProtocol {

    var video: Video

    init(video: Video) {
        self.video = video
    }

    var userName: String {
        return video.userName
    }

    var viewCounts: String {
        return video.viewCounts == 1 ? "\(video.viewCounts) view" :  "\(video.viewCounts) views"
    }

    var videoTitle: String {
        return video.title
    }

    var videoId: String {
        return video.videoId
    }

    func getThumbUrl(with size: (Int, Int)) -> URL? {
        guard let url = URL(string: video.thumbUrl.replacingOccurrences(of: "%{width}", with: "\(size.0)").replacingOccurrences(of: "%{height}", with: "\(size.1)")) else {
            return nil
        }
        return url
    }

    func downloadThumb(with size: (Int, Int), then handler: @escaping (Data?) -> Void) {

        if let imageData = defaultCache[videoId] {
            handler(imageData)
        } else {

            guard let imageUrl = getThumbUrl(with: size) else {
                handler(nil)
                return
            }

            URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
                if let error = error {
                    print("Couldn't download image: ", error)
                    return
                }

                defaultCache[self.videoId]  = data
                handler(data)
            }.resume()
        }
    }

}
