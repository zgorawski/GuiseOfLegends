//
//  ChampionSkinVC.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 27/04/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import UIKit

class ChampionSkinVC : UIViewController {
    
    var championId: String!
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func onBackTap() {
        dismiss(animated: true, completion: nil)
    }
}
