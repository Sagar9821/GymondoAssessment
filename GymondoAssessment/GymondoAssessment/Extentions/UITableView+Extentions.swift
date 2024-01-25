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
    
    func reloadWithAnimation() {
        self.reloadData()
        var delayCounter = 0
        let tableViewSize = bounds.size
        let cells = visibleCells
        for cell in cells {
            cell.alpha = 0
            UIView.animate(withDuration: 0.1, delay: 0.05*Double(delayCounter),animations: {
                cell.alpha = 1
            })
            delayCounter += 1
        }
    }
}
