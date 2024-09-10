//
//  MainViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 3.09.24.
//

import UIKit

final class GalleryViewController: UIViewController {
    
    var user: User!
    
    // MARK: - Private properties
    private let storageManager = StorageManager.shared
    private let savedImages = SavedImages.shared
    private let sectionInsert = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    private let itemsPerRow: CGFloat = 2
    
    private var isSelectionModeActive = false
    private var selectedImages = [UIImage]()
    
    private var numberOfSelectedPhotos: Int {
        return imagesCollectionView.indexPathsForSelectedItems?.count ?? 0
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var noContentStackView: UIStackView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var welcomLabel: UILabel!
    @IBOutlet weak var selectBarButton: UIBarButtonItem!
    @IBOutlet weak var deletedBarButton: UIBarButtonItem!
    
    // MARK: - Life cycle view
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.allowsMultipleSelection = false
        
        updateNavButtonState()
        
        guard let user = user else { return }
        welcomLabel.text = "Welcome, \(user.name!)! Your image is here"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagesCollectionView.reloadData()
        updateStackViewVisibility()
    }
    
    // MARK: - IBAction methods
    @IBAction func deletedBarButtonAction(_ sender: UIBarButtonItem) {
        if !savedImages.photos.isEmpty {
            if let selectedIndexPaths = imagesCollectionView.indexPathsForSelectedItems {
                let indicesToDelete = selectedIndexPaths.map { $0.item }
                
                for index in indicesToDelete.sorted(by: >) {
                    savedImages.photos.remove(at: index)
                }
            imagesCollectionView.deleteItems(at: selectedIndexPaths)
            }
        }
    }
    
    
    @IBAction func selectBarButtonAction(_ sender: UIBarButtonItem) {
        toggleSelectionMode()
    }
    
    // MARK: - Private methods
    private func toggleSelectionMode() {
        isSelectionModeActive.toggle()
        imagesCollectionView.allowsMultipleSelection = isSelectionModeActive
        
        selectBarButton.title = isSelectionModeActive ? "Undo" : "Select"
      
        if !isSelectionModeActive {
            if let selectedItems = imagesCollectionView.indexPathsForSelectedItems {
                for indexPath in selectedItems {
                    imagesCollectionView.deselectItem(at: indexPath, animated: false)
                    
                    if let cell = imagesCollectionView.cellForItem(at: indexPath) as? GalleryCollectionViewCell {
                        cell.setSelected(false)
                        }
                    }
                }
            }
        imagesCollectionView.reloadData()
        }
    
    private func updateNavButtonState() {
        deletedBarButton.isEnabled = numberOfSelectedPhotos > 0
    }
    
    private func updateStackViewVisibility() {
        if savedImages.photos.isEmpty {
               noContentStackView.isHidden = false
           } else {
               noContentStackView.isHidden = true
           }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isSelectionModeActive {
            updateNavButtonState()

            let cell = imagesCollectionView.cellForItem(at: indexPath) as! GalleryCollectionViewCell
            guard let image = cell.imageView.image else { return }
            selectedImages.append(image)
            cell.setSelected(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isSelectionModeActive {
            
            updateNavButtonState()
            let cell = imagesCollectionView.cellForItem(at: indexPath) as! GalleryCollectionViewCell
            guard let image = cell.imageView.image else { return }
            if let index = selectedImages.firstIndex(of: image) {
                selectedImages.remove(at: index)
                selectedImages.removeAll()
            cell.setSelected(false)
            }
        }
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

