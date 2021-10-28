//
//  LoginView.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 26/10/21.
//

import UIKit

class LoginView: BaseNibView {
    
    //MARK: Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
}

extension LoginView {
    //MARK: Setup
    public func configure(_ viewModel: LoginViewModel) {
        usernameTextField.placeholder = viewModel.usernamePlaceholder
        passwordTextField.placeholder = viewModel.passwordPlaceholder
        passwordTextField.isSecureTextEntry = true
        signInButton.setTitle(viewModel.signInTitle.uppercased(), for: .normal)
        signInButton.backgroundColor = .none
        signInButton.layer.cornerRadius = 20
        signInButton.layer.borderWidth = 1.5
        signInButton.layer.borderColor = UIColor.appColor(.borderButtonInitial)!.cgColor
    }
}
