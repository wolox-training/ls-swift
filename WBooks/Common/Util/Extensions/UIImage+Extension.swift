//
//  UIImage+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 2/11/21.
//

import UIKit

enum AssetsImage: String {
    case iconBack = "IconBack"
    case iconNotification = "IconNotification"
    case iconSearch = "IconSearch"
    case iconTab1 = "IconTab1"
    case iconTab2 = "IconTab2"
    case iconTab3 = "IconTab3"
    case iconTab4 = "IconTab4"
    case Commentator1 = "Commentator1"
    case Commentator2 = "Commentator2"
    case addPhoto = "AddPhoto"
}

extension UIImage {
    static func loadAssets(_ name: AssetsImage) -> UIImage? {
        return UIImage(named: name.rawValue)
    }
}
