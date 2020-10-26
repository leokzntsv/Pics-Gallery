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
    var pictureId: Int!
    
    let pictureImageView = PictureImageView(frame: .zero)
    let titleLabel       = PictureTitleLabel(fontSize: 20)
    
    var onDoneBlock: ((Bool) -> Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configurePictureImageView()
        configureTitleLabel()
    }
    
    
    @objc private func dismissVC() {
        dismiss(animated: true)
        onDoneBlock!(true)
    }
    
    
    private func setPictureImageView(with urlString: String) {
        
        guard let imageIsSaved = CoreDataManager.shared.checkById(id: pictureId) else { return }
        
        if imageIsSaved {
            let image = CoreDataManager.shared.fetchImage(id: pictureId)
            self.pictureImageView.image = image
        } else {
            NetworkManager.shared.downloadPicture(from: urlString) { [weak self] (image) in
                guard let self = self, let image = image else { return }
                DispatchQueue.main.async {
                    CoreDataManager.shared.saveImage(id: self.pictureId, image: image)
                    self.pictureImageView.image = image
                }
            }
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
        titleLabel.numberOfLines    = 2
        
        view.addSubview(titleLabel)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: pictureImageView.topAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
}
