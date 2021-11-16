//
//  UIButton+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 12/11/21.
//

import UIKit
import SwiftUI

enum ButtonStyle {
    case blue
    case grey
    case transparent
}

extension UIButton {
    func setStyle(_ buttonStyle: ButtonStyle) {
        defaultStyle()
        switch buttonStyle {
        case .blue:
            guard let gradient1 = UIColor.appColor(.gradientB1)?.cgColor, let gradient2 = UIColor.appColor(.gradientB2)?.cgColor else {
                fatalError("Failed to load the color")
            }
            addGradient(colors: [gradient1, gradient2])
        case .grey:
            guard let gradient1 = UIColor.appColor(.gradientBD1)?.cgColor,
                  let gradient2 = UIColor.appColor(.gradientBD2)?.cgColor,
                  let gradient3 = UIColor.appColor(.gradientBD3)?.cgColor else {
                fatalError("Failed to load the color")
            }
            addGradient(colors: [gradient1, gradient2, gradient3])
        case .transparent:
            self.setTitleColor(UIColor.appColor(.secondaryColor), for: .normal)
            self.backgroundColor = .clear
            addBlueBorder()
        }
    }
    
    func addBlueBorder() {
        let blueColor = UIColor.appColor(.secondaryColor)
        self.layer.borderColor = blueColor?.cgColor
        self.layer.borderWidth = 1
    }
    
    func defaultStyle() {
        self.layer.cornerRadius = 22
        self.setTitleColor(.white, for: .normal)
        self.clipsToBounds = true
    }
    
    func addGradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = colors.count == 2 ? [0, 1] : [0, 0.4523078762755102, 1]
        gradientLayer.startPoint = CGPoint(x: 0.06, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
