//
//  ChampionsRequest.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import Foundation
import Alamofire

struct ChampionsRequest {
    
    let apiKey: String?
}

extension ChampionsRequest: Request {
    
    var httpMethod: Alamofire.Method { return .GET }
    
    var endpoint: String {
        
        if case .Some = apiKey {
            return "https://global.api.pvp.net/api/lol/static-data/eune/v1.2/champion"
        } else { // slower alternative, not reccomended
            return "TODO"
        }
    }
    
    var parameters: [String: AnyObject]? {
        
        if let apiKey = apiKey {
            return ["champData": "image", "api_key": apiKey]
        } else { // slower alternative, not reccomended
            return nil
        }
    }
}
