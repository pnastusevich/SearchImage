//
//  SplashScreenViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 3.09.24.
//

import UIKit

final class SplashScreenViewController: UIViewController {
    
    private let storageManager = StorageManager.shared
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.fetchData()
        }
    }
    
    private func fetchData() {
            storageManager.fetchData { result in
                switch result {
                case .success(let users):
                    if users.isEmpty {
                        self.performSegue(withIdentifier: "registrationScreen", sender: nil)
                    } else {
                        self.performSegue(withIdentifier: "usersListScreen", sender: nil)
                    }
                case .failure(let error):
                    print (error.localizedDescription)
                }
                
            }
        }
    
    
}
