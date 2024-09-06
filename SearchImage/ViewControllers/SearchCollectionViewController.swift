//
//  SearchCollectionViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 5.09.24.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController {

    
    var user: User!

    var request = "flowers"
    private var images: [Images] = []
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! SearchImageCollectionViewCell
        let image = images[indexPath.row]
        cell.configure(with: image)
        return cell
    }

    // MARK: Private Methods
    private func fetchImages() {
        networkManager.fetchData(request) { result in
            switch result {
            case .success(let images):
                self.images = images.hits
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}
