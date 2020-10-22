//
//  PictureImageView.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 22.10.2020.
//

import UIKit

class PictureImageView: UIImageView {
    
    let placeholderImage = UIImage(systemName: "photo")
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        contentMode         = .scaleAspectFit
        tintColor           = .systemGray
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
