//
//  LoginViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 27/10/21.
//

import UIKit

protocol LoginViewModelType {
    var usernamePlaceholder: String { get }
    var passwordPlaceholder: String { get }
    var signInTitle: String { get }
}

public class LoginViewModel: LoginViewModelType {
    
    var usernamePlaceholder: String {
        "usernamePlaceholder".localized()
    }
    
    var passwordPlaceholder: String {
        "passwordPlaceholder".localized()
    }
    
    var signInTitle: String {
        "signInTitle".localized()
    }
}
