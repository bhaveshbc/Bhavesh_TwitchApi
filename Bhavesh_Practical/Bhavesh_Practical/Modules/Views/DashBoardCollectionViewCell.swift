//
//  DashBoardCollectionViewCell.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import UIKit
var defaultCache = Cache<String, Data>()
class DashBoardCollectionViewCell: UICollectionViewCell, ConfigurableCell {

    @IBOutlet var userName: UILabel!
    @IBOutlet var viewsCount: UILabel!
    @IBOutlet var videoTitle: UILabel!
    @IBOutlet var videoImage: UIImageView!

    func configure(_ item: VideoViewModel, at indexPath: IndexPath) {
        userName.text = item.userName
        viewsCount.text = item.viewCounts
        videoTitle.text = item.videoTitle
        videoImage.image = nil
        item.downloadThumb(with: (200, 120)) { [unowned self] data in
            if let imageData = data, let thumbImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.videoImage.image = thumbImage
                }
            }
        }
    }
}
