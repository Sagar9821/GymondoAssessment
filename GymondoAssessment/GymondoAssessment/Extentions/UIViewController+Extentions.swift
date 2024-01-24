//
//  UIViewController+Extentions.swift
//  GymondoAssessment
//
//  Created by psagc on 20/01/24.
//

import UIKit

typealias retryAction = ((UIAlertAction) -> Void)

extension UIViewController {
    
    
    public static var storyboardID: String {
        return String(describing: self)
    }
    
    func showAlert(title: String?, message: String,actions: [UIAlertAction] = [],retry: retryAction?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        } else {
            for action in actions {
                alertController.addAction(action)
            }
        }
        if let retryAction = retry {
            alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: retry))
        }
        present(alertController, animated: true)
    }
}
