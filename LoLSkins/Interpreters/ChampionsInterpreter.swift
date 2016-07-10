//
//  ChampionsInterpreter.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import Foundation
import Unbox

class ChampionsInterpreter {
    
    //
    // returns nil if unable to interpret data
    func interpret(json: NSData) -> [LoLChampion]? {
        
        guard let intermidiateObject: IntermidiateObject = try? Unbox(json) else { return nil }
        
        return Array(intermidiateObject.data.values)
    }
    
    private struct IntermidiateObject: Unboxable {
        let data: [String: LoLChampion]
        
        init(unboxer: Unboxer) {
            self.data = unboxer.unbox("data")
        }
    }
}

extension LoLChampion: Unboxable {
    
    init(unboxer: Unboxer) {
        self.name = unboxer.unbox("name")
    }
}
