//
//  LoginPageViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 3.09.24.
//

import UIKit

final class LoginPageViewController: UIViewController {
    
    var user: User!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var welcomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hello, \(user.name ?? "")"
        welcomLabel.text = "Your email: \(user.mail ?? "")"
    }
    
    // скрываем клавиатуру по нажатию по экрану
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainVC = segue.destination as? MainViewController else { return }
        
        guard let userName = user.name else { return }
        mainVC.userName = userName
        guard let userEmail = user.mail else { return }
        mainVC.userEmail = userEmail
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard passwordTextField.text == user.password else {
            showAlert(withTitle: "Invalid password", andMessage: "Please, enter correct password")
            return false
        }
        return true
    }
     
    
    // MARK: Private Methods
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.passwordTextField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}
