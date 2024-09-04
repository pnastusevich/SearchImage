//
//  RegistrationViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 3.09.24.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    var userEmail = ""
    var userName = ""
    var userPassword = ""

    private var users: [User] = []
    
    private let storageManager = StorageManager.shared
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainViewController = segue.destination as? MainViewController else { return }
        mainViewController.userEmail = userEmail
        mainViewController.userName = userName
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let nameTF = nameTextField.text else { return false }
        guard let emailTF = emailTextField.text else { return false }
        guard let passwordTF = passwordTextField.text else { return false }
        
        saveUser(email: emailTF, name: nameTF, password: passwordTF)
        return true
    }
    
    // скрываем клавиатуру по нажатию по экрану
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
        
    private func saveUser(email: String, name: String, password: String) {
        storageManager.create(email, name, password)
        userEmail = email
        userName = name
    }
}

