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
}

extension UIImage {
    static func loadAssets(_ name: AssetsImage) -> UIImage? {
        return UIImage(named: name.rawValue);
    }
}
