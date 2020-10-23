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
    let titleLabel              = PictureTitleLabel(fontSize: 14)
    let downloadedImageView     = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurePictureImageView()
        configureTitleLabel()
        configureDownloadedImageView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(picture: Picture) {
        titleLabel.text = picture.title
        
        guard let imageIsSaved = CoreDataManager.shared.checkById(id: picture.id) else { return }
        downloadedImageView.tintColor = imageIsSaved ? .systemGreen : .systemGray2
        
        NetworkManager.shared.downloadPicture(from: picture.thumbnailUrl) { [weak self] (image) in
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
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 3
        
        addSubview(titleLabel)
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func configureDownloadedImageView() {
        downloadedImageView.image = UIImage(systemName: "square.and.arrow.down.fill")
        
        addSubview(downloadedImageView)
        downloadedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            downloadedImageView.topAnchor.constraint(equalTo: pictureImageView.topAnchor, constant: padding),
            downloadedImageView.trailingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: -padding),
            downloadedImageView.heightAnchor.constraint(equalToConstant: 30),
            downloadedImageView.widthAnchor.constraint(equalTo: downloadedImageView.heightAnchor)
        ])
    }
}
