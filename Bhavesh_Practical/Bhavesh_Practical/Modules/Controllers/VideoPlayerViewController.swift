//
//  VideoPlayerViewController.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 29/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import UIKit
import WebKit

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var twitchPlayerOuterView: UIView!
    // MARK: - Variable Declaration
    var nextVideoIndex = 0
    var videosArray = [String]()
    private let viewModel = VideoPlayerViewModel()
    private var twitchPlayer: WKWebView!

     // MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setupWebView()
        }
    }

    private func setupWebView() {
        let configuration = WKWebViewConfiguration()
               configuration.allowsInlineMediaPlayback = true
        twitchPlayer = WKWebView(frame: self.twitchPlayerOuterView.bounds, configuration: configuration)
        self.twitchPlayerOuterView.addSubview(self.twitchPlayer)
        guard nextVideoIndex < videosArray.count else { return }
        playVideo(videoId: self.videosArray[self.nextVideoIndex])
    }

    // MARK: - Custom methods

    /// function responsible construct HTML for video Player with given VideoID
    /// - Parameter videoId: VideoID
    private func playVideo(videoId: String) {
        let videoHtml = viewModel.getHtmlFor(videoId: videoId)
        twitchPlayer.loadHTMLString(videoHtml, baseURL: nil)
    }

    /// Play next Video from videosArray
    /// - Parameter sender: UIButton Instance
    @IBAction func nextButtonPress(_ sender: Any) {
        let videoToPlay = videosArray[nextVideoIndex]
        nextVideoIndex = (nextVideoIndex + 1) % videosArray.count
        playVideo(videoId: videoToPlay)
    }
}
