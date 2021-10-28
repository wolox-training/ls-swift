//
//  UIColor+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 27/10/21.
//

import UIKit

enum AssetsColor: String {
    case borderButtonInitial = "BorderButtonInitial"
    case primaryColor = "PrimaryColor"
    case secondaryColor = "SecondaryColor"
}

extension UIColor {
    
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue);
    }
    
}
