//
//  NetworkManager.swift
//  SearchImage
//
//  Created by Паша Настусевич on 5.09.24.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(_ request: String, completion:  @escaping(Result<ImageModel, NetworkError>) -> Void) {
        guard let url = URL(string: "https://pixabay.com/api/?key=15734811-98e7f49bb68d0671f5d17e7bc&q=\(request)") else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let images = try JSONDecoder().decode(ImageModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(images))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
            
        }.resume()
    }
    
}
