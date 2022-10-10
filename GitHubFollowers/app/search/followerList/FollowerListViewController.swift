//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Monika Mateska on 9.10.22.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    var username: String!
    var collectionView: UICollectionView!
    var page: Int = 1
    var followers: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        loadFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func loadFollowers() {
        Task {
            do {
                let response = try await NetworkManager.shared.getFollowers(username: username,
                                                                            page: page)
                followers.append(contentsOf: response)
                page += 1
            } catch {
                var errorMessage = "Failed to load the followers"
                if let error = error as? NetworkError {
                    errorMessage = error.rawValue
                }
                presentErrorAlert(message: errorMessage)
            }
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let cellWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)
        
        return flowLayout
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
}
