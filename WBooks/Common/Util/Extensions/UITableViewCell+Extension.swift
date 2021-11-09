//
//  UITableViewCell+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 2/11/21.
//

import UIKit

extension UITableViewCell {
    var selectionColor: UIColor {
        get {
            return self.selectedBackgroundView?.backgroundColor ?? UIColor.clear
        }
        set {
            let view = UIView()
            view.backgroundColor = newValue
            self.selectedBackgroundView = view
        }
    }
}
