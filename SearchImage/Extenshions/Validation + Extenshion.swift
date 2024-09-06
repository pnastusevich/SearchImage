//
//  Validation + Extenshion.swift
//  SearchImage
//
//  Created by Паша Настусевич on 4.09.24.
//

import UIKit

extension RegistrationViewController {
    
    func validateData() -> Bool {
        
        guard let nameInput = nameTextField.text, !nameInput.isEmpty else {
            showAlert(withTitle: "Text field is empty", andMessage: "Please enter your name")
            return false
        }
        let userNamePattern = "^[a-zA-Z ]{3,20}$"
        let isUserNameValid = NSPredicate(format: "SELF MATCHES %@", userNamePattern)
            .evaluate(with: nameInput)
        
        if !isUserNameValid {
            showAlert(withTitle: "Wrong format user name", andMessage: "Please enter your name")
            return false
        }
        
        guard let mailInput = emailTextField.text, !mailInput.isEmpty else {
            showAlert(withTitle: "Email is empty", andMessage: "Please enter valid email")
            return false
        }
        let userMailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let isUserMailValid = NSPredicate(format: "SELF MATCHES %@", userMailPattern)
            .evaluate(with: mailInput)
        
        if !isUserMailValid {
            showAlert(withTitle: "Wrong format email", andMessage: "Please enter valid email")
            return false
        }
        
        guard let passwordInput = passwordTextField.text, !passwordInput.isEmpty else {
            showAlert(withTitle: "Password is empty", andMessage: "Please enter your password")
            return false
        }
        let userPasswordPattern = "^.{8,}$"
        let isPasswordValid = NSPredicate(format: "SELF MATCHES %@", userPasswordPattern)
            .evaluate(with: passwordInput)
        
        if !isPasswordValid {
            showAlert(withTitle: "Wrong format password", andMessage: "Please enter a password of 8 characters")
            return false
        
        }
       return true
    }
}
