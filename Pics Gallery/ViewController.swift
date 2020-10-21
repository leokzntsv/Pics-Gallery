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
        
        NetworkManager.shared.getPictures(album: 1) { (pictures, errorMessage) in
            guard let pictures = pictures else {
                print(errorMessage!)
                return
            }
            
            print("\(pictures.count)")
            print(pictures)
        }
    }
}

