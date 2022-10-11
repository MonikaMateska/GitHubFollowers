//
//  GHFollowerItemViewController.swift
//  GitHubFollowers
//
//  Created by Monika Mateska on 11.10.22.
//

import Foundation

class GHFollowerItemViewController: GHItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        configureButtonAction()
    }
    
    private func configureItems() {
        firstInfoView.set(type: .followers, count: user.followers)
        secondInfoView.set(type: .following, count: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    private func configureButtonAction() {
        
    }
}
