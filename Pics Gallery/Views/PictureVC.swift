//
//  PictureVC.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 22.10.2020.
//

import UIKit

class PictureVC: UIViewController {
    
    var pictureTitle: String!
    var pictureUrl: String!
    
    let pictureImageView = PictureImageView(frame: .zero)
    let titleLabel       = PictureTitleLabel(fontSize: 20)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configurePictureImageView()
        configureTitleLabel()
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    private func setPictureImageView(with urlString: String) {
        NetworkManager.shared.downloadPicture(from: urlString) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.pictureImageView.image = image }
        }
    }
    
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    private func configurePictureImageView() {
        setPictureImageView(with: pictureUrl)
        
        view.addSubview(pictureImageView)
        
        NSLayoutConstraint.activate([
            pictureImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pictureImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    
    private func configureTitleLabel() {
        titleLabel.text             = pictureTitle
        titleLabel.lineBreakMode    = .byWordWrapping
        titleLabel.numberOfLines    = 2
        
        view.addSubview(titleLabel)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: pictureImageView.topAnchor, constant: -50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
}
