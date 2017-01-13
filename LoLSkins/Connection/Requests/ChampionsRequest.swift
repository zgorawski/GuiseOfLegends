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
    
    var httpMethod: Alamofire.HTTPMethod { return .get }
    
    var endpoint: String {
        
        if case .some = apiKey {
            return "https://global.api.pvp.net/api/lol/static-data/eune/v1.2/champion"
        } else { // slower alternative, not reccomended
            return "http://zgriotapi.azurewebsites.net/api/champions"
        }
    }
    
    var parameters: [String: AnyObject]? {
        
        if let apiKey = apiKey {
            return ["champData": "skins" as AnyObject, "api_key": apiKey as AnyObject]
        } else { // slower alternative, not reccomended
            return nil
        }
    }
}
