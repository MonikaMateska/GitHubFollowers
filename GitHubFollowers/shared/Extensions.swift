//
//  Extensions.swift
//  GitHubFollowers
//
//  Created by Monika Mateska on 9.10.22.
//

import UIKit

extension UIViewController {
    
    func presentErrorAlert(title: String, message: String, buttonText: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: buttonText, style: .destructive))
            self.present(alertController, animated: true)
        }
    }
    
}
