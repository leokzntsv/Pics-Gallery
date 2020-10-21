//
//  NetworkManager.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 21.10.2020.
//

import Foundation

class NetworkManager {
    static let shared   = NetworkManager()
    let baseURL         = "http://jsonplaceholder.typicode.com/albums/"
    
    private init() {}
    
    
    func getPictures(album: Int, completed: @escaping ([Picture]?, String?) -> Void) {
        let endpoint = baseURL + "\(album)/photos"
        
        
    }
}
