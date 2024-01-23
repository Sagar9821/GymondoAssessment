//
//  UIViewController+Extentions.swift
//  GymondoAssessment
//
//  Created by psagc on 20/01/24.
//

import UIKit


extension UIViewController {
    public static var storyboardID: String {
        return String(describing: self)
    }
    
    func showAlert(title: String?, message: String,actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        } else {
            for action in actions {
                alertController.addAction(action)
            }
        }
        present(alertController, animated: true)
    }
}
