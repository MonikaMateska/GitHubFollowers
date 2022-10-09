//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Monika Mateska on 9.10.22.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    var username: String!
    var page: Int = 1
    var followers: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
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
                print("Followers = \(followers.count)")
            } catch {
                presentErrorAlert(message: "Failed to load the followers")
            }
        }
    }
}
