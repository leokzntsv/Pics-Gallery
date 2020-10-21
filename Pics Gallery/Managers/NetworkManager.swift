//
//  NetworkManager.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 21.10.2020.
//

import Foundation

class NetworkManager {
    static let shared   = NetworkManager()
    let baseURL         = "https://jsonplaceholder.typicode.com/albums/"
    
    private init() {}
    
    
    func getPictures(album: Int, completed: @escaping (Result<[Picture], ErrorMessage>) -> Void) {
        let endpoint = baseURL + "\(album)/photos"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let pictures = try JSONDecoder().decode([Picture].self, from: data)
                completed(.success(pictures))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
