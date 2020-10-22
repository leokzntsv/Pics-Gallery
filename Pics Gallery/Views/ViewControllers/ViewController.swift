//
//  ViewController.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 21.10.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getPictures(album: 1) { result in
            switch result {
            case .success(let pictures):
                print("\(pictures.count)")
                print(pictures)
            case .failure(let error):
                print(error)
            }
        }
    }
}

