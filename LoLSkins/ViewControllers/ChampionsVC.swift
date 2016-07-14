//
//  ChampionsVC.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import UIKit


class ChampionsVC: UICollectionViewController {
    
    private let championsCellRI = String(ChampionsCell)
    private var model: [LoLChampion] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    // MARK: dependencies
    
    lazy var championsController = ChampionsController()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView?.delegate = self
        collectionView?.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        //setContentInsets()
        
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
        
        let itemWidth: CGFloat = 120.0 * (UIScreen.mainScreen().scale)
        let minSpacingForCells: CGFloat = 10.0 * (UIScreen.mainScreen().scale)
        let containerWidth = CGFloat(collectionView!.contentSize.width)
        
        // only 1 item fit case
        if 2.0 * (itemWidth + minSpacingForCells) > containerWidth {
            
            let margin = containerWidth - itemWidth / 2.0
            collectionView?.contentInset = UIEdgeInsets(top: 0.0, left: margin, bottom: 0.0, right: margin)
        }
        // 2 items fit case
        else if 3.0 * itemWidth + 4.0 * minSpacingForCells > containerWidth {
            let margin = (containerWidth - 2.0 * itemWidth) / 3.0
            print("margin: \(margin)")
            collectionView?.contentInset = UIEdgeInsets(top: 0.0, left: margin, bottom: 0.0, right: margin)
        } else {
            
            // TODO:
            let margin: CGFloat = 5.0
            collectionView?.contentInset = UIEdgeInsets(top: 0.0, left: margin, bottom: 0.0, right: margin)
        }
        
        

//        let elements = floor(containerWidth / (itemWidth + 2.0 * minSpacingForCells))
//        let emptySpace = containerWidth - itemWidth * elements
//        let marginSpace = emptySpace / (elements + 1.0)
//        
//        print("margin: \(marginSpace)")
//        
//        collectionView?.contentInset = UIEdgeInsets(top: 0.0, left: marginSpace, bottom: 0.0, right: marginSpace)
        
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

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return model.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(championsCellRI, forIndexPath: indexPath)
    
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
