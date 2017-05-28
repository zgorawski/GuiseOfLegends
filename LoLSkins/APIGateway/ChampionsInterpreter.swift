//
//  ChampionsInterpreter.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 07/05/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import SOLIDNetworking
import SwiftyJSON

class GetChampionsInterpreter: SOLIDNetworking.Interpreter {
    
    func interpret(data: Data?, response: HTTPURLResponse?, error: Error?) -> SOLIDNetworking.Result<[LoLChampion], APIError> {
        
        guard error == nil, response?.statusCode == 200, let data = data else {
            return SOLIDNetworking.Result.error(APIError.connection)
        }
        
        let json = JSON(data: data)
        
        guard let dataJson = json["data"].dictionary else { return SOLIDNetworking.Result.error(APIError.connection) }
        
        let champions = dataJson.flatMap({ (key: String, value: JSON) -> LoLChampion? in
            
            guard
                let title = value["title"].string,
                let id = value["id"].int,
                let name = value["name"].string,
                let championKey = value["key"].string,
                let skinsJson = value["skins"].array
                else { return nil }
            
            let skins: [Skin] = skinsJson.flatMap({ json in
                
                guard
                    let num = json["num"].int,
                    let id = json["id"].int,
                    let name = json["name"].string
                    else { return nil }
                
                return Skin(num: num, id: id, name: name)
                
            })
            
            return LoLChampion(id: id, title: title, name: name, key: championKey, skins: skins)
            
        })
        
        return SOLIDNetworking.Result.success(champions)
    }
}

struct LoLChampion {
    let id: Int
    let title: String
    let name: String
    let key: String
    let skins: [Skin]
}

struct Skin {
    let num: Int
    let id: Int
    let name: String
}
