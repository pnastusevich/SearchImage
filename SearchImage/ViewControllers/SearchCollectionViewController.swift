//
//  SearchCollectionViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 5.09.24.
//

import UIKit

final class SearchCollectionViewController: UIViewController {
   
    var selectedImageLink: Images?
    
    private let networkManager = NetworkManager.shared
    private let savedImages = SavedImages.shared

    private let itemsPerRow: CGFloat = 3
    private let sectionInsert = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    private var timer: Timer?
    private var images = [Images]()
    private var selectedImages = [UIImage]()
    
    private var isSelectionModeActive = false
   
    private var numberOfSelectedPhotos: Int {
        return imageCollectionView.indexPathsForSelectedItems?.count ?? 0
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var chooseBarButton: UIBarButtonItem!
    @IBOutlet weak var actionBarButton: UIBarButtonItem!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    
    // MARK: - Life cycle view
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.allowsMultipleSelection = false
        
        updateNavButtonState()
        setupSearchBar()
    }

    // MARK: - IBAction methods
    @IBAction func actionBarButtonTapped(_ sender: UIBarButtonItem) {
        let shareController = UIActivityViewController(activityItems: selectedImages, applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                self.refresh()
            }
        }
        shareController.popoverPresentationController?.barButtonItem = sender
        shareController.popoverPresentationController?.permittedArrowDirections = .any
        present(
            shareController,
            animated: true,
            completion: nil
        )
    }
  
    @IBAction func saveBarButtonAction(_ sender: UIBarButtonItem) {
        for selectedImage in selectedImages {
            savedImages.photos.append(selectedImage)
        }
            showAlert(withTitle: "Images saved",
                      andMessage: "All images are stored in the gallery"
            )
        }
    
    @IBAction func choiseBarButtonTapped(_ sender: UIBarButtonItem) {
        toggleSelectionMode()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail" {
                let imageInfoVC = segue.destination as? ImageInfoViewController
                imageInfoVC?.selectedImage = selectedImageLink
            }
        }
    
    // MARK: - Private methods
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func toggleSelectionMode() {
        isSelectionModeActive.toggle()
        imageCollectionView.allowsMultipleSelection = isSelectionModeActive
        
        chooseBarButton.title = isSelectionModeActive ? "Undo" : "Selected"
      
        if !isSelectionModeActive {
            if let selectedItems = imageCollectionView.indexPathsForSelectedItems {
                for indexPath in selectedItems {
                    imageCollectionView.deselectItem(at: indexPath, animated: false)
                    
                    if let cell = imageCollectionView.cellForItem(at: indexPath) as? SearchImageCollectionViewCell {
                        cell.setSelected(false)
                        }
                    }
                }
            }
        imageCollectionView.reloadData()
        }
    
    private func updateNavButtonState() {
        actionBarButton.isEnabled = numberOfSelectedPhotos > 0
        saveBarButton.isEnabled = numberOfSelectedPhotos > 0
    }
        
    private func refresh() {
        self.selectedImages.removeAll()
        
        if let selectedItems = imageCollectionView.indexPathsForSelectedItems {
            for indexPath in selectedItems {
                imageCollectionView.deselectItem(at: indexPath, animated: false)
                
                if let cell = imageCollectionView.cellForItem(at: indexPath) as? SearchImageCollectionViewCell {
                    cell.setSelected(false)
                }
            }
            imageCollectionView.reloadData()
        }
        updateNavButtonState()
    }
}

// MARK: Extension UICollectionViewDelegate, UICollectionViewDataSource
extension SearchCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! SearchImageCollectionViewCell
    
        let image = images[indexPath.item]
        cell.loadImage(with: image)
        
        let isSelected = imageCollectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        cell.setSelected(isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isSelectionModeActive {
            updateNavButtonState()
            
//            updateSendButtonState()
            let cell = imageCollectionView.cellForItem(at: indexPath) as! SearchImageCollectionViewCell
            guard let image = cell.imageView.image else { return }
            selectedImages.append(image)
            cell.setSelected(true)
            
            
        } else {
            self.selectedImageLink = images[indexPath.row]
            performSegue(withIdentifier: "showDetail", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isSelectionModeActive {
            
            updateNavButtonState()
            let cell = imageCollectionView.cellForItem(at: indexPath) as! SearchImageCollectionViewCell
            guard let image = cell.imageView.image else { return }
            if let index = selectedImages.firstIndex(of: image) {
                selectedImages.remove(at: index)
                selectedImages.removeAll()
            cell.setSelected(false)
            }
        }
    }
}

extension SearchCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
   }
}


// MARK: Extension UICollectionViewDelegateFlowLayout
extension SearchCollectionViewController: UICollectionViewDelegateFlowLayout {
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

// MARK: Extension UISearchBarDelegate
extension  SearchCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkManager.fetchData(searchText) { result in
                    switch result {
                        case .success(let images):
                           self.images = images.hits
                           self.imageCollectionView.reloadData()
                            self.refresh()
                       case .failure(let error):
                           print(error)
                }
            }
        })
    }
}
