//
//  SavedImage.swift
//  SearchImage
//
//  Created by Паша Настусевич on 9.09.24.
//

import UIKit

final class SavedImages {
    
    static let shared = SavedImages()
    
    private init() {}
    
    var photos: [UIImage] = []
    
}
