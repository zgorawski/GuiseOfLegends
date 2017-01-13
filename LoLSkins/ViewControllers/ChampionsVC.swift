//
//  ChampionsVC.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class ChampionsVC: UICollectionViewController {
    
    // !! https://github.com/kean/Preheat
    // !! https://github.com/kean/Nuke
    
    fileprivate let championsCellRI = "ChampionsCell"
    fileprivate var model: [LoLChampion] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    // MARK: dependencies
    
    lazy var championsController: ChampionsController = ChampionsController()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView?.delegate = self
        
        // collectionView?.contentInset = UIEdgeInsets(top: 0.0, left: 35.0, bottom: 0.0, right: 35.0)
        

        setContentInsets()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.registerClass(ChampionsCell.self, forCellWithReuseIdentifier: championsCellRI)
        

        // Do any additional setup after loading the view.
        
        championsController.fetchChampions { champions in
            if let champions = champions {
                self.model = champions
            }
        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return model.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: championsCellRI, for: indexPath)
    
        // Configure the cell
        if let championsCell = cell as? ChampionsCell {
            
            championsCell.backgroundColor = UIColor(randomString: model[indexPath.item].name)
            championsCell.championNameLabel.text = model[indexPath.item].name
        }
    
        return cell
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        
//        let itemWidth = 120.0
//        let containerWidth = Double(collectionView.contentSize.width)
//        let elements = containerWidth % itemWidth
//        let emptySpace = containerWidth - itemWidth * elements
//        let marginSpace = emptySpace / (elements + 1.0)
//        
//        return UIEdgeInsets(top: 0.0, left: CGFloat(marginSpace), bottom: 0.0, right: CGFloat(marginSpace))
//        
//    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//        
//        let itemWidth = 120.0
//        let containerWidth = Double(collectionView.contentSize.width)
//        let elements = containerWidth % itemWidth
//        let emptySpace = containerWidth - itemWidth * elements
//        let marginSpace = emptySpace / (elements + 1.0)
//        
//        return CGFloat(marginSpace)
//        
//    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        
//        let itemWidth = 120.0
//        let containerWidth = Double(collectionView.contentSize.width)
//        let elements = containerWidth % itemWidth
//        let emptySpace = containerWidth - itemWidth * elements
//        let marginSpace = emptySpace / elements + itemWidth
//        
//        return CGFloat(marginSpace)
//    }
}
