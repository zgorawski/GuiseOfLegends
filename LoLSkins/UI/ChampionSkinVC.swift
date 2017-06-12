//
//  ChampionSkinVC.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 27/04/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import UIKit

class ChampionSkinVC : UIViewController {
    
    var viewModel: [SkinVM]!
    fileprivate var currentSkinName: String? { didSet {
        navigationController?.navigationBar.topItem?.title = currentSkinName
        }
    }
    fileprivate var nextSkinName: String? = nil
    fileprivate var vertSizeClass: UIUserInterfaceSizeClass!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("initial traitCollection: \(traitCollection)")

        currentSkinName = "default"
        vertSizeClass = traitCollection.verticalSizeClass
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
        navigationController?.navigationBar.backItem?.title = " "
        currentSkinName = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        nextSkinName = nil
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        print("willTransition to traitCollection: \(newCollection)")
        vertSizeClass = newCollection.verticalSizeClass
        
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.layoutIfNeeded()
        
        coordinator.animate(alongsideTransition: nil) { (context) in
            print("finished transition")
            self.collectionView.reloadData()
        }
    }
}

extension ChampionSkinVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkinCellRI", for: indexPath)
        
        if let skinCell = cell as? SkinCell {
            
            let model = viewModel[indexPath.row]
            let imgUrl = vertSizeClass == .compact ? model.splashUrl : model.portraitUrl
            
            skinCell.skinImage.af_setImage(withURL: imgUrl)
        }
        
        return cell
    }
}


extension ChampionSkinVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        print("size: \(collectionView.bounds.size)")
        
        if (vertSizeClass == .compact) {
            return CGSize(
                width: max(collectionView.bounds.size.height, collectionView.bounds.size.width),
                height: min(collectionView.bounds.size.height, collectionView.bounds.size.width))
        }
        
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if( currentSkinName == nil) {
            currentSkinName = viewModel[indexPath.row].name
        } else {
            nextSkinName = viewModel[indexPath.row].name
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (viewModel[indexPath.row].name == currentSkinName) {
            currentSkinName = nextSkinName
        }
    }
}
