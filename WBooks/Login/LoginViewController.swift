//
//  LoginViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 22/10/21.
//

import UIKit

final class LoginViewController: BaseViewController {

    //MARK: - Variables
    private lazy var loginView: LoginView = LoginView()
    private let loginViewModel: LoginViewModel = LoginViewModel()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.configure(loginViewModel)
        addTargetButtonToSignIn()
        loginView.usernameTextField.delegate = self
        loginView.passwordTextField.delegate = self
        initializeHideKeyboard()
        registerNotification()
    }
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unRegisterNotification()
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unRegisterNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Actions
    @objc private func signInTapped() {
        print("WELCOME User: \(String(describing: loginView.usernameTextField.text!))")
    }
        
    private func addTargetButtonToSignIn() {
        loginView.signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

extension LoginViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = loginView.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        loginView.scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        loginView.scrollView.contentInset = contentInset
    }
}
