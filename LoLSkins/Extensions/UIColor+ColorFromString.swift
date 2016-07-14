//
//  UIColor+ColorFromString.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 14.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(randomString: String) {
        
        let rFactor = (Float(abs(randomString.hash)) / 17.0) % 255.0 / 255.0
        let gFactor = (Float(abs(randomString.hash)) / 13.0) % 255.0 / 255.0
        let bFactor = (Float(abs(randomString.hash)) / 11.0) % 255.0 / 255.0
        
        self.init(colorLiteralRed: rFactor, green: gFactor, blue: bFactor, alpha: 1.0)
    }
}
