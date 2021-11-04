//
//  BaseViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 27/10/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func tapOutside() {
        view.endEditing(true)
    }
    
    func initNavigation(title: String, hasBack: Bool) {
        navigationItem.title = title
        if (hasBack) {
            let backItem = UIBarButtonItem(customView: setIcon(position: 0.0, imageName: .iconBack))
            backItem.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backRedirection)))
            navigationItem.leftBarButtonItem = backItem
        } else {
            navigationItem.hidesBackButton = true
        }
    }
    
    private func setIcon(position: Double, imageName: AssetsImage) -> UIView {
        let frame: CGRect = CGRect(x: 0.0, y: 0.0, width: 18.0, height: 18.0)
        let iconView: UIView = UIView(frame: frame)
        let imageView: UIImageView = UIImageView(frame: frame)
        imageView.image = UIImage.loadAssets(imageName)
        iconView.addSubview(imageView)
        return iconView
    }
    
    @objc func backRedirection() {
        navigationController?.popViewController(animated: true)
    }
    
    func addNavBarRightIcon(iconName: AssetsImage, tapGestureRecognizer: UITapGestureRecognizer) {
        let rightItem = UIBarButtonItem(customView: setIcon(position: 0.0, imageName: iconName))
        rightItem.customView?.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func addNavBarLeftIcon(iconName: AssetsImage, tapGestureRecognizer: UITapGestureRecognizer) {
        let leftItem = UIBarButtonItem(customView: setIcon(position: 0.0, imageName: iconName))
        leftItem.customView?.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = leftItem
    }
}
