//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Monika Mateska on 11.10.22.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
        
        loadUserData()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func loadUserData() {
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: self.username)
                print(user)
            } catch {
                let mappedError = error as! NetworkError
                presentErrorAlert(message: "Failed loading user info. \(mappedError.rawValue).")
            }
        }
    }
}
