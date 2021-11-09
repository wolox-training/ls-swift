//
//  UIViewController+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 27/10/21.
//

import UIKit

extension UIViewController {
    func initializeHideKeyboard() {
        // Declare a Tap Gesture Recognizer which will trigger our dismissKeyboard() function
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        // Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    open func present(_ viewControllerToPresent: UIViewController,
                      animated flag: Bool,
                      pushing: Bool,
                      transitionSubtype: CATransitionSubtype = CATransitionSubtype.fromRight,
                      completion: (() -> Void)? = nil) {
        if pushing {
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = transitionSubtype
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            view.window?.layer.add(transition, forKey: kCATransition)
            viewControllerToPresent.modalPresentationStyle = .fullScreen
            self.present(viewControllerToPresent, animated: false, completion: completion)
        } else {
            self.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
}
