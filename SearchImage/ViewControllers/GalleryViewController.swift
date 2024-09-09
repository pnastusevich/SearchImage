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
    private let savedImages = SavedImages.shared
    private let sectionInsert = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    private let itemsPerRow: CGFloat = 2
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var welcomLabel: UILabel!
    
    
    // MARK: - Life cycle view
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        
        guard let user = user else { return }
        welcomLabel.text = "Welcome, \(user.name!)!"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagesCollectionView.reloadData()
    }

}

// MARK: Extension UICollectionViewDelegate, UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! GalleryCollectionViewCell
        let image = savedImages.photos[indexPath.item]
        cell.imageView.image = image
        
        return cell
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        savedImages.photos.count
    }
}

// MARK: Extension UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInsert.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsert
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsert.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsert.left
    }
}

