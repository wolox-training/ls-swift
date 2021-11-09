//
//  UIImageView+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 8/11/21.
//

import UIKit

extension UIImageView {
    func loadImageRemote(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let dataImage = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: dataImage)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.image = UIImage(named: "Cover6")
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.image = UIImage(named: "Cover6")
            }
        }
    }
}
