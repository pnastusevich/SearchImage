//
//  GalleryViewCell.swift
//  SearchImage
//
//  Created by Паша Настусевич on 9.09.24.
//

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10.0

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setSelected(_ selected: Bool) {
            
        if selected {
            imageView.alpha = 0.7
        } else {
            imageView.alpha = 1
        }
            
       }
    
}
