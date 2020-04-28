//
//  VideoList.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

struct VideoList: Decodable {
    let videoList: [Video]

    enum CodingKeys: String, CodingKey {
        case videoList = "data"
    }

    init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
          videoList = try values.decode([Video].self, forKey: .videoList)
      }
}

struct Video: Decodable {
    let videoId: String
    let userId: String
    let userName: String
    let title: String
    let description: String
    let url: String
    let thumbUrl: String
    let viewCounts: Int

    enum CodingKeys: String, CodingKey {
        case videoId = "id"
        case userId = "user_id"
        case userName = "user_name"
        case title = "title"
        case description = "description"
        case url = "url"
        case thumbUrl = "thumbnail_url"
        case viewCounts = "view_count"
    }

    init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
          videoId = try values.decode(String.self, forKey: .videoId)
        userId = try values.decode(String.self, forKey: .userId)
        userName = try values.decode(String.self, forKey: .userName)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        url = try values.decode(String.self, forKey: .url)
        thumbUrl = try values.decode(String.self, forKey: .thumbUrl)
        viewCounts = try values.decode(Int.self, forKey: .viewCounts)
      }
}
