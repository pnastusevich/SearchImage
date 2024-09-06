//
//  SearchImageCollectionViewCell.swift
//  SearchImage
//
//  Created by Паша Настусевич on 5.09.24.
//

import UIKit

class SearchImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let networkManager = NetworkManager.shared
    
    func configure(with image: Images) {
        guard let imageURL = URL(string: image.webformatURL) else { return }
        
        networkManager.fetchImage(from: imageURL) { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.imageView.image = UIImage (data: imageData)
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
