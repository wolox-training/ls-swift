//
//  TabBarViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 3/11/21.
//

import UIKit

enum MenuTabBar: String, CaseIterable {
  case library
  case wishlist
  case suggest
  case rentals
}

public class TabBarViewModel: NSObject {
    func getViewControllers() -> [UIViewController] {
        var tabItems: TabBarItems = []
        
        for tabs in MenuTabBar.allCases {
            switch tabs {
            case .library:
                tabItems.append(TabBarItem.library)
            case .wishlist:
                tabItems.append(TabBarItem.wishlist)
            case .suggest:
                tabItems.append(TabBarItem.suggest)
            case .rentals:
                tabItems.append(TabBarItem.rentals)
            }
        }
        
        let viewControllers = tabItems
            .sorted { $0.order < $1.order }
            .compactMap {toViewController(for: $0)}
        return viewControllers
    }
    
    private func toViewController(for item: TabBarItem) -> UIViewController {
        let tabBarItem = UITabBarItem(
            title: item.title,
            image: UIImage(named: item.image),
            selectedImage: UIImage(named: item.selectedImage)
        )
        var rootViewController: UIViewController = UIViewController()
        switch item.order {
        case 1:
            rootViewController = UIViewController()
        case 2:
            let viewModel: SuggestBookViewModelType = SuggestBookViewModel()
            rootViewController = SuggestBookController(viewModel: viewModel)
        case 3:
            let viewModel: BooksTableViewModelType = RentalsViewModel()
            rootViewController = RentalsViewController(viewModel: viewModel)
        default:
            let viewModel: LibraryViewModel = LibraryViewModel()
            rootViewController = LibraryViewController(viewModel: viewModel)
        }
        tabBarItem.tag = item.order
        let viewController = NavigationController(rootViewController: rootViewController)
        viewController.tabBarItem = tabBarItem
        return viewController
    }
}
