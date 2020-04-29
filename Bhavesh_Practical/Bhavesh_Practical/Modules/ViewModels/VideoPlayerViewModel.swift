//
//  VideoPlayerViewModel.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 29/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import Foundation

struct  VideoPlayerViewModel {
    var playerHtml =  """
       <html>
       <body>
       <iframe
           src="https://player.twitch.tv/?video=%{VideoId}&autoplay=true"
           height="100%"
           width="100%"
           frameborder="0"
           scrolling="no"
           allowfullscreen="false">
       </iframe>
       </body>
       </html>
       """

    func getHtmlFor(videoId: String) -> String {
        return playerHtml.replacingOccurrences(of: "%{VideoId}", with: videoId)
    }
}
