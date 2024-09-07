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
                
            } else if let searchVC = navigationVC.topViewController as? SearchCollectionViewController {
                searchVC.user = user
                
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
