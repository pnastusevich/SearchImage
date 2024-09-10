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
    @IBOutlet weak var saveButton: UIButton!
    
    let savedImage = SavedImages.shared
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.backgroundColor = UIColor.white
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.shadowColor = UIColor.darkGray.cgColor
        saveButton.layer.shadowRadius = 5.0
        saveButton.layer.shadowOpacity = 0.1
        saveButton.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        
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
            savedImage.photos.append(imageInfoView.image!)
            showAlert(withTitle: "Save image done", andMessage: "Image saves")
        }
    }

