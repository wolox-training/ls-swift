//
//  UIView+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 26/10/21.
//

import UIKit

public protocol NibLoadeable: UIView {}

public extension NibLoadeable {
    
    /**
     *  Returns a `UIView` object instantiated from nib
     */
    func instantiateFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
    
    /**
     *  Load the content of the first view in the XIB.
     *  Then add this as subview with constraints
     */
    func loadNibContent() {
        guard let view = instantiateFromNib() else {
            fatalError("Failed to instantiate \(String(describing: Self.self)).xib")
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        let views = ["view": view]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                                 options: .alignAllLastBaseline,
                                                                 metrics: nil,
                                                                 views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|",
                                                                 options: .alignAllLastBaseline,
                                                                 metrics: nil,
                                                                 views: views)
        addConstraints(verticalConstraints + horizontalConstraints)
    }
}

extension UIView {
    func shadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.appColor(.shadowBoxColor)!.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
    }
}
