//
//  TabBarItem.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 3/11/21.
//

import UIKit

struct TabBarItem: Codable {
    let title,
        image,
        selectedImage: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case title,
             image,
             selectedImage
        case order
    }
    
    static let library = TabBarItem(
        title: "libraryTitleTabBar".localized(),
        image: "IconTab1",
        selectedImage: "IconTab1",
        order: 0
    )
    static let wishlist = TabBarItem(
        title: "wishlistTitleTabBar".localized(),
        image: "IconTab2",
        selectedImage: "IconTab2",
        order: 1
    )
    static let suggest = TabBarItem(
        title: "suggestTitleTabBar".localized(),
        image: "IconTab3",
        selectedImage: "IconTab3",
        order: 2
    )
    static let rentals = TabBarItem(
        title: "rentalsTitleTabBar".localized(),
        image: "IconTab4",
        selectedImage: "IconTab4",
        order: 3
    )
}
