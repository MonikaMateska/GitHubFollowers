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
    let itemViewOne = UIView()
    let itemViewTwo = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
        
        configureUI()
        loadUserData()
    }
    
    private func loadUserData() {
        showLoadingView()
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: self.username)
                hideLoadingView()
                addChildViewController(GHUserInfoViewController(user: user), to: headerView)
                addChildViewController(GHRepoItemViewController(user: user), to: itemViewOne)
                addChildViewController(GHFollowerItemViewController(user: user), to: itemViewTwo)
            } catch {
                hideLoadingView()
                let mappedError = error as! NetworkError
                presentErrorAlert(message: "Failed loading user info. \(mappedError.rawValue).")
            }
        }
    }
    
    private func configureUI() {
        configureHeaderView()
        configureViewOne()
        configureViewTwo()
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
    
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140
    
    private func configureViewOne() {
        view.addSubview(itemViewOne)
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
    
    private func configureViewTwo() {
        view.addSubview(itemViewTwo)
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
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
