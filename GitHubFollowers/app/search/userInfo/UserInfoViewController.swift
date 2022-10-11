//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Monika Mateska on 11.10.22.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var username: String!
    
    let headerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
        loadUserData()
        configureUI()
    }
    
    private func loadUserData() {
        showLoadingView()
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: self.username)
                hideLoadingView()
                addChildViewController(GHUserInfoViewController(user: user), to: headerView)
            } catch {
                hideLoadingView()
                let mappedError = error as! NetworkError
                presentErrorAlert(message: "Failed loading user info. \(mappedError.rawValue).")
            }
        }
    }
    
    private func configureUI() {
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func addChildViewController(_ childVC: UIViewController, to contrainerView: UIView) {
        addChild(childVC)
        contrainerView.addSubview(childVC.view)
        childVC.view.frame = contrainerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}
