//
//  ImageInfoViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 7.09.24.
//

import UIKit

final class ImageInfoViewController: UIViewController {
    
    var selectedImage: Images?
    
    @IBOutlet weak var imageInfoView: UIImageView!
    
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        imageInfoView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func fetchImage() {
        guard let selectedImage else { return }
        guard let imageURL = URL(string: selectedImage.largeImageURL) else { return }
        networkManager.fetchImage(from: imageURL) { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.imageInfoView.image = UIImage (data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func saveImageButtonn(_ sender: UIButton) {
            showAlert(withTitle: "Save image done", andMessage: "Image saves")
        }
    }

