//
//  MainViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 3.09.24.
//

import UIKit

final class MainViewController: UIViewController {
    
    var userEmail = ""
    var userName = ""
    
    private let storageManager = StorageManager.shared

    @IBOutlet weak var welcomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomLabel.text = "Welcome, \(userName)! Email is \(userEmail)"
        
    }

    @IBAction func deleteActionButton() {
        
    }
    
}
