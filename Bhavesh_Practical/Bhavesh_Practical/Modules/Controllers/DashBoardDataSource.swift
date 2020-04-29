//
//  DashBoardDataSource.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 29/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import UIKit

class DashBoardDataSource: CollectionArrayDataSource<VideoViewModel, DashBoardCollectionViewCell>, UICollectionViewDelegateFlowLayout {

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 120)
    }
}
