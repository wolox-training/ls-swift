//
//  AlertAction.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 15/11/21.
//

import UIKit

struct AlertAction {
    var title: String
    var style: UIAlertAction.Style
    
    static func action(title: String, style: UIAlertAction.Style = .default) -> AlertAction {
        return AlertAction(title: title, style: style)
    }
}
