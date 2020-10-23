//
//  PictureCollectionVC.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 22.10.2020.
//

import UIKit

class PictureCollectionVC: UICollectionViewController {
    
    var pictures: [Picture] = []
    var page: Int           = 1
    var hasMorePictures     = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        configureCollectionView()
        getPictures(page: page)
    }
    
    
    private func configureCollectionView() {
        collectionView.backgroundColor      = .systemBackground
        collectionView.collectionViewLayout = createFlowLayout()
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: PictureCell.reuseID)
    }
    
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 15
        let minimumItemSpacing: CGFloat = 15
        let availableWidth              = width - (padding * 2) - minimumItemSpacing * 2
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 50)
        
        return flowLayout
    }
    
    
    func getPictures(page: Int) {
        showLoadingView()
        NetworkManager.shared.getPictures(album: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let pictures):
                if pictures.count < 50 { self.hasMorePictures = false }
                self.pictures.append(contentsOf: pictures)
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .failure(let error):
                print(error)
            }
            
            self.dismissLoadingView()
        }
    }
    
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.reuseID, for: indexPath) as! PictureCell
        cell.set(picture: pictures[indexPath.item])
        
        return cell
    }
    

    // MARK: - UICollectionViewDelegate
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMorePictures else { return }
            page += 1
            getPictures(page: page)
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture             = pictures[indexPath.item]
        
        let destVC              = PictureVC()
        destVC.pictureTitle     = picture.title
        destVC.pictureUrl       = picture.url
        destVC.pictureId        = picture.id
        
        destVC.onDoneBlock      = { result in
            collectionView.reloadData()
        }
        
        let navController       = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}
