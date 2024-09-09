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
    @IBOutlet weak var selectionOverlay: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = true
        checkMark.isHidden = true
        
        selectionOverlay.backgroundColor = UIColor.clear
        selectionOverlay.layer.borderColor = UIColor.systemBlue.cgColor
        selectionOverlay.layer.borderWidth = 3
        selectionOverlay.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setSelected(_ selected: Bool) {
           selectionOverlay.isHidden = !selected
           checkMark.isHidden = !selected
       }

    func loadImage(with image: Images) {
        guard let imageURL = URL(string: image.previewURL) else { return }
        imageView.sd_setImage(with: imageURL, completed: nil)
    }
}
