//
//  VideoPlayerViewController.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 29/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import UIKit
import TwitchPlayer

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var twitchPlayer: TwitchPlayer!
    var nextVideoIndex = 0
    var videosArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard nextVideoIndex < videosArray.count else { return }
        twitchPlayer.setVideo(to: videosArray[nextVideoIndex], timestamp: 0)
    }

    @IBAction func togglePlaybackPress(_ sender: Any) {
        twitchPlayer.togglePlaybackState()
    }

    @IBAction func nextButtonPress(_ sender: Any) {
        let videoToPlay = videosArray[nextVideoIndex]
        nextVideoIndex = (nextVideoIndex + 1) % videosArray.count
        twitchPlayer.setVideo(to: videoToPlay, timestamp: 0)
    }
}
