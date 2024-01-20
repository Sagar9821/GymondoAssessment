//
//  UITableView+Extentions.swift
//  GymondoAssessment
//
//  Created by psagc on 20/01/24.
//

import UIKit

extension UITableView {
    
    func getCell<T: UITableViewCell>(_ type: T.Type) -> T?{
        let identifier = String(describing: type)
        if let cell = dequeueReusableCell(withIdentifier: identifier) as? T {
            return cell
        }
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        return getCell(type)
    }
}
