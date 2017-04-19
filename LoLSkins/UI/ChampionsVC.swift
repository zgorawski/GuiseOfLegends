//
//  ChampionsVC.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import UIKit
import AlamofireImage

class ChampionsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let championsCellRI = "ChampionsCell"
    fileprivate var viewModel: [ChampionsVM] = []
    
    // MARK: dependencies
    
    fileprivate var championsPresenter: ChampionsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        championsPresenter = ChampionsPresenter(subscriber: self)
        
        collectionView.dataSource = self
        
        // setContentInsets()
        
    }
    
    func setContentInsets() {
        
        let itemWidth: CGFloat = 120.0
        let minSpacingForCells: CGFloat = 10.0
        let containerWidth = CGFloat(collectionView!.bounds.width)
        
        let elementsCount = floor((containerWidth + minSpacingForCells) / (itemWidth + minSpacingForCells))
        let freeSpace = containerWidth - elementsCount * itemWidth
        let newSpacing = max(minSpacingForCells, freeSpace / (elementsCount + 1.0))
        let spaceForMargins = freeSpace - newSpacing * (elementsCount - 1.0)
        let margin = spaceForMargins / 2.0
        
        print("calculated margin: \(margin)")
        
        collectionView?.contentInset = UIEdgeInsets(top: 0.0, left: margin, bottom: 0.0, right: margin)
        
    }

    // MARK: UICollectionViewDataSource



}

extension ChampionsVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: championsCellRI, for: indexPath)
        
        if let championsCell = cell as? ChampionsCell {
            
            let championVM = viewModel[indexPath.item]
            championsCell.backgroundColor = UIColor(randomString: championVM.key)
            championsCell.portraitImageView.af_setImage(withURL: championVM.imageUrl)
        }
        
        return cell
    }
}

extension ChampionsVC: ChampionsPresenterSubscriber {
    
    func present(champions: [ChampionsVM]) {
        viewModel = champions
        collectionView.reloadData()
    }
    
    func show(error: ErrorVM) {
        print("error: \(error.title): \(error.message)")
    }
    
}
