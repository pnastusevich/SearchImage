//
//  SettingsViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 5.09.24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var user: User!
    let storageManager = StorageManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func deleteActionButton() {
        showAlert(withTitle: "The user will be deleted", andMessage: "Are you sure you want to do this?")
    }

}

extension SettingsViewController {
    
    func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.storageManager.delete(user!)
            self.performSegue(withIdentifier: "deleteUser", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}
