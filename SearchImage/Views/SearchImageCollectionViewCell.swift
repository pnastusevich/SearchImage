//
//  SearchImageCollectionViewCell.swift
//  SearchImage
//
//  Created by Паша Настусевич on 5.09.24.
//

import UIKit
import SDWebImage

final class SearchImageCollectionViewCell: UICollectionViewCell {
    
    private let networkManager = NetworkManager.shared
   
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = true
        checkMark.isHidden = true
        imageView.layer.cornerRadius = 10.0
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setSelected(_ selected: Bool) {
           checkMark.isHidden = !selected
            
        if selected {
            imageView.alpha = 0.7
        } else {
            imageView.alpha = 1
        }
            
       }


    func loadImage(with image: Images) {
        guard let imageURL = URL(string: image.previewURL) else { return }
        imageView.sd_setImage(with: imageURL, completed: nil)
    }
}
