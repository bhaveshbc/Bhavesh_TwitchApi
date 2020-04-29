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

    // MARK: - Variable Declaration
    private let viewModel = DashBoardViewModel()
    weak var coordinator: DashboardCoordinator?
    private var dashBoardDataSource: DashBoardDataSource?
    private var userId = 60056333
    private var activityView = UIActivityIndicatorView(style: .gray)

    // MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DashBoard"
        // Do any additional setup after loading the view.

        let tokenRequest = UserRequest(clientId: TwitchConstant.clientID.rawValue, clientSecret: TwitchConstant.clientSecrete.rawValue)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.isHidden = false
        activityView.startAnimating()
        getUserAccessToken(with: tokenRequest)
    }

     // MARK: - API Handler

    /// function responsible for retrieve access token from Twitch. this access token will be used for next API calls.
    /// - Parameter request: UserRequest instance
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

    /// function responsible for Fetch videos by userId from Server(Twitch Api)
    /// - Parameter userId: user id instance
       private func getVideoBy(userId: Int) {
           viewModel.getVideos(by: userId) { [unowned self] response in
               switch response {
               case .success(let model):
                   DispatchQueue.main.async {
                       self.stopActivityIndicator()
                       self.prepareDataSource(with: model)
                   }
               case .failure(let apiError):
                   self.showError(message: apiError.errorDescriptions)
               }
           }
       }

    // MARK: - Custom methods
    private func stopActivityIndicator() {
        activityView.stopAnimating()
        activityView.isHidden = true
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

    /// function responsible for save user details like user access token etc.
    /// - Parameter user: UserModel Instance
    private func saveUserDetail(user: UserModel) {
        do {
            try viewModel.saveLoggedUserToUserDefault(user: user)
        } catch let error {
            self.presentAlertMessage(message: error.localizedDescription)
        }
    }

    /// Show given error string on Alert ViewController
    /// - Parameter message: Error message
    private func showError(message: String) {
        DispatchQueue.main.async {
            self.stopActivityIndicator()
            self.presentAlertMessage(message: message)
        }
    }
}
