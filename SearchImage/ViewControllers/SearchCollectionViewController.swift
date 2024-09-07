//
//  SearchCollectionViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 5.09.24.
//

import UIKit

final class SearchCollectionViewController: UIViewController {

    var user: User!
   
    let itemsPerRow: CGFloat = 3
    let sectionInsert = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    
    private var images: [Images] = []
    private let networkManager = NetworkManager.shared
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var imageCollectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        searchTextField.delegate = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = imageCollectionView.indexPathsForSelectedItems else { return }
//        
//        let imageInfoVC = segue.destination as? ImageInfoViewController
//        imageInfoVC?.image = images[indexPath.row]

        if segue.identifier == "showDetail" {
            if let imageInfoVC = segue.destination as? ImageInfoViewController,
            let images = sender as? Images {
                imageInfoVC.image = images.webformatURL
            }
        }
    }

    // MARK: Network Methods
    private func fetchData() {
        guard let searchTF = searchTextField.text else { return }
        networkManager.fetchData(searchTF) { result in
            switch result {
            case .success(let images):
                self.images = images.hits
                self.imageCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: Extension UICollectionViewDelegate
extension SearchCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! SearchImageCollectionViewCell
        let image = images[indexPath.row]
        cell.configure(with: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = images[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: selectedImage)
    }
}

// MARK: Extension UICollectionViewDataSource
extension SearchCollectionViewController: UICollectionViewDataSource{
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

// MARK: Extension UITextFieldDelegate
extension SearchCollectionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        fetchData()
        
        return false
    }
}
