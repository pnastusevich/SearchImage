//
//  MainViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 3.09.24.
//

import UIKit

final class GalleryViewController: UIViewController {
    
    var user: User!
    private let storageManager = StorageManager.shared

    @IBOutlet weak var welcomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = user else { return }
        welcomLabel.text = "Welcome, \(user.name!)!"
    }
}


