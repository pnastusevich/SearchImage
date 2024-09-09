//
//  ImageModel.swift
//  SearchImage
//
//  Created by Паша Настусевич on 5.09.24.
//

import Foundation

struct ImageModel: Decodable {
    
    let totalHits: Int
    let hits: [Images]
}

struct Images: Decodable {
    let tags: String
    let user: String
    let previewURL: String
    let webformatURL: String
    let largeImageURL: String
}
