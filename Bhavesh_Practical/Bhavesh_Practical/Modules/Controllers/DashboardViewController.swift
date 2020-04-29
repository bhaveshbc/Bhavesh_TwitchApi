//
//  ViewController.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 28/04/20.
//  Copyright © 2020 Bhavesh. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet var dashboardCollectionView: UICollectionView!

    let viewModel = DashBoardViewModel()
    weak var coordinator: DashboardCoordinator?
    var dashBoardDataSource: DashBoardDataSource?
    var userId = 60056333

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let tokenRequest = UserRequest(clientId: TwitchConstant.clientID.rawValue, clientSecret: TwitchConstant.clientSecrete.rawValue)
        getUserAccessToken(with: tokenRequest)
    }

    private func getUserAccessToken(with request: UserRequest) {
        viewModel.getUserToken(with: request) { [unowned self] response in
            switch response {
            case .success(let model):
                DispatchQueue.main.async {
                    self.saveUserDetail(user: model)
                    self.getVideoBy(userId: self.userId)
                }
            case .failure(let apiError):
                self.showError(message: apiError.errorDescriptions)
            }
        }
    }

    private func getVideoBy(userId: Int) {
        viewModel.getVideos(by: userId) { [unowned self] response in
            switch response {
            case .success(let model):
                DispatchQueue.main.async {
                    self.prepareDataSource(with: model)
                }
            case .failure(let apiError):
                self.showError(message: apiError.errorDescriptions)
            }
        }
    }

    // construct dataSource for DashBoard collectionView
    private func prepareDataSource(with videos: [VideoViewModel]) {
        self.dashBoardDataSource = DashBoardDataSource(collectionView: self.dashboardCollectionView, array: videos)
            guard let dataSource = self.dashBoardDataSource else { return }
            let videosId = viewModel.getVideoIds()
            dataSource.collectionItemSelectionHandler = { [unowned self] indexPath in
                self.coordinator?.presentVideoPlayerController(with: videosId, selectedIndex: indexPath.item)
            }
    }

    private func saveUserDetail(user: UserModel) {
        do {
            try viewModel.saveLoggedUserToUserDefault(user: user)
        } catch let error {
            self.presentAlertMessage(message: error.localizedDescription)
        }
    }

    private func showError(message: String) {
        DispatchQueue.main.async {
            self.presentAlertMessage(message: message)
        }
    }
}

class DashBoardDataSource: CollectionArrayDataSource<VideoViewModel, DashBoardCollectionViewCell>, UICollectionViewDelegateFlowLayout {

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 120)
    }
}
