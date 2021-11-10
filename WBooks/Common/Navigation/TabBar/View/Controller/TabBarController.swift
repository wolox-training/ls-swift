//
//  TabBarController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 28/10/21.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: Properties
    var viewModel = TabBarViewModel()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewControllers = viewModel.getViewControllers()
    }
    
    // MARK: Custom methods
    private func configure() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor.appColor(.secondaryColor)
    }
}
