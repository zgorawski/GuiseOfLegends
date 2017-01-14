//
//  ChampionsInterpreter.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChampionsInterpreter {
    
    //
    // returns nil if unable to interpret data
    func interpret(_ json: JSON) -> [LoLChampion]? {
        
        guard let data = json["data"].dictionary else { return nil }
        
        let champions = data.map({ (key: String, value: JSON) -> LoLChampion? in
            
            guard
                let name = value["name"].string,
                let championKey = value["key"].string
            else { return nil }
            
            return LoLChampion(name: name, key: championKey)
            
        }).flatMap({ $0 })
        
        return champions
    }
    
}

