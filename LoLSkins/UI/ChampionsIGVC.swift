//
//  ChampionsIGVC.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 14/01/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import UIKit
import IGListKit

class ChampionsIGVC: UIViewController, IGListAdapterDataSource {
    
    @IBOutlet weak var collectionView: IGListCollectionView!
    var adapter: IGListAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let updater = IGListAdapterUpdater()
        adapter = IGListAdapter(updater: updater, viewController: self, workingRangeSize: 0)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        // this can be anything!
        return ["Foo" as IGListDiffable, "Bar" as IGListDiffable, "Biz" as IGListDiffable ]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {

            return LabelSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
}

class LabelSectionController: IGListSectionController, IGListSectionType {
    
    var object: String?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: IGChampionsCell.self, for: self, at: index) as! IGChampionsCell
        //cell.championNameLabel.text = object
        return cell
    }

    func didUpdate(to object: Any) {
        self.object = String(describing: object)
    }
    
    func didSelectItem(at index: Int) {}
    
}

class IGChampionsCell: UICollectionViewCell {
    
    @IBOutlet weak var championNameLabel: UILabel!
}


