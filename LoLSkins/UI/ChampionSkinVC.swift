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
    
    fileprivate var currentSkinIndexPath: IndexPath? {
        didSet {
            guard let ip = currentSkinIndexPath else {
                navigationController?.navigationBar.topItem?.title = nil
                return
            }
            navigationController?.navigationBar.topItem?.title = viewModel[ip.row].name
            pageControl.currentPage = ip.row
        }
    }
    
    fileprivate var nextSkinIndexPath: IndexPath? = nil
    fileprivate var vertSizeClass: UIUserInterfaceSizeClass!
    fileprivate var isTransition = false

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentSkinIndexPath = IndexPath(row: 0, section: 0)
        vertSizeClass = traitCollection.verticalSizeClass
        collectionView.dataSource = self
        collectionView.delegate = self
        pageControl.numberOfPages = viewModel.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
        navigationController?.navigationBar.backItem?.title = " "
        currentSkinIndexPath = nil
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
        
        nextSkinIndexPath = nil
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        isTransition = true
        guard let ip = currentSkinIndexPath else { return }
        print("scroll to: \(ip)")
        
        vertSizeClass = newCollection.verticalSizeClass
        
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()

        coordinator.animate(alongsideTransition: nil) { [weak self] (context) in
            self?.collectionView.reloadData()
            self?.collectionView.scrollToItem(at: ip, at: UICollectionViewScrollPosition.left, animated: false)
            self?.isTransition = false
        }
        
        collectionView.scrollToItem(at: ip, at: UICollectionViewScrollPosition.left, animated: false)
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
        
        guard !isTransition else { return }
        
        if( currentSkinIndexPath == nil) {
            currentSkinIndexPath = indexPath
        } else {
            nextSkinIndexPath = indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard !isTransition else { return }
        
        if (indexPath == currentSkinIndexPath) {
            currentSkinIndexPath = nextSkinIndexPath
        }
    }
}
