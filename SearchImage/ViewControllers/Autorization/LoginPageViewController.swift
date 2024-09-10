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
    
    @IBOutlet weak var loginInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginInButton.backgroundColor = UIColor.white
        loginInButton.layer.cornerRadius = 10.0
        loginInButton.layer.shadowColor = UIColor.darkGray.cgColor
        loginInButton.layer.shadowRadius = 5.0
        loginInButton.layer.shadowOpacity = 0.1
        loginInButton.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        
        
        title = "Hello, \(user.name ?? "")"
        welcomLabel.text = "Your email: \(user.mail ?? ""). Enter your password"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tapBarVC = segue.destination as? TapBarViewController else { return }
        
        tapBarVC.viewControllers?.forEach{ viewController in
            guard let navigationVC = viewController as? UINavigationController else { return }
            
            if let galleryVC = navigationVC.topViewController as? GalleryViewController {
                galleryVC.user = user
            
            } else if let settingsVC = navigationVC.topViewController as? SettingsViewController {
                settingsVC.user = user
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard passwordTextField.text == user.password else {
            showAlert(withTitle: "Invalid password", andMessage: "Please, enter correct password")
            return false
        }
        return true
    }
    

}
