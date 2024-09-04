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

    
    // скрываем клавиатуру по нажатию на экран
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
//     MARK: IBAction Methods
    @IBAction func loginInButton(_ sender: UIButton) {
        if validateData() {
            saveUser(email: emailTextField.text ?? "", name: nameTextField.text ?? "", password: passwordTextField.text ?? "")
        } else { return }
    }
    
    // MARK: Private Methods
    private func saveUser(email: String, name: String, password: String) {
        storageManager.create(email, name, password)
        userEmail = email
        userName = name
    }
}

