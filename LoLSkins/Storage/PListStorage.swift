//
//  PListStorage.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import Foundation

class PListStorage {
    
    func readValue<T>(forKey key: String, inPlist plist: String) -> T? {
        
        guard let path = Bundle.main.path(forResource: plist, ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            return nil
        }
        
        return dict[key] as? T
    }
}
