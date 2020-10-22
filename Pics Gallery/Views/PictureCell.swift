//
//  PictureCell.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 22.10.2020.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    static let reuseID          = "PictureCell"
    let pictureImageView        = PictureImageView(frame: .zero)
    let titleLabel              = PictureTitleLabel(fontSize: 16)
    let isDownloadedImageView   = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurePictureImageView()
        configureTitleLabel()
        configureIsDownloadedImageView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(picture: Picture, isDownloaded: Bool) {
        titleLabel.text                 = picture.title
        isDownloadedImageView.tintColor = isDownloaded ? .systemGreen : .systemGray2
        
        NetworkManager.shared.downloadThumbnail(from: picture.thumbnailUrl) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.pictureImageView.image = image }
        }
    }
    
    
    private func configurePictureImageView() {
        addSubview(pictureImageView)
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            pictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            pictureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            pictureImageView.heightAnchor.constraint(equalTo: pictureImageView.widthAnchor)
        ])
    }
    
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    private func configureIsDownloadedImageView() {
        isDownloadedImageView.image     = UIImage(systemName: "square.and.arrow.down.fill")
        
        addSubview(isDownloadedImageView)
        isDownloadedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            isDownloadedImageView.topAnchor.constraint(equalTo: pictureImageView.topAnchor, constant: padding),
            isDownloadedImageView.trailingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: -padding),
            isDownloadedImageView.heightAnchor.constraint(equalToConstant: 30),
            isDownloadedImageView.widthAnchor.constraint(equalTo: isDownloadedImageView.heightAnchor)
        ])
    }
}
