//
//  ImageInfoViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 7.09.24.
//

import UIKit

final class ImageInfoViewController: UIViewController {
    
    var image = ""
    @IBOutlet weak var imageInfoView: UIImageView!
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    private func fetchImage() {
        guard let imageURL = URL(string: image) else { return }
        networkManager.fetchImage(from: imageURL) { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.imageInfoView.image = UIImage (data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }

   

}
