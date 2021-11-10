//
//  UITableView+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 29/10/21.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: .main),
                      forCellReuseIdentifier: String(describing: T.self))
    }
}
