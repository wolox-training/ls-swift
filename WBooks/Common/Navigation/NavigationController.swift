//
//  NavigationController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 28/10/21.
//

import UIKit

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    func configuration() {
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        navigationBar.barStyle = .black
        navigationBar.barTintColor = .clear
        navigationBar.tintColor = .clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
