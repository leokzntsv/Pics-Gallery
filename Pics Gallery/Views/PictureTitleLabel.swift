//
//  PictureTitleLabel.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 22.10.2020.
//

import UIKit

class PictureTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    
    private func configure() {
        textColor                   = .label
        textAlignment               = .center
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
