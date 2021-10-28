//
//  BaseViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 27/10/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func tapOutside() {
        view.endEditing(true)
    }
}
