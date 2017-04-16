//
//  GetChampions.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 16/04/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import Alamofire
import SOLIDNetworking
import SwiftyJSON

class ChampionsAPI {
    
    private let engine: NetworkingEngine
    private let plistStorage: PListStorage
    
    init(plistStorage: PListStorage = PListStorage(), engine: NetworkingEngine = NetworkingEngine()) {
        self.plistStorage = plistStorage
        self.engine = engine
    }
    
    // MARK: API
    
    func fetchChampions() {
        
        guard let apiKey: String? = plistStorage.readValue(forKey: "APIKey", inPlist: "APIKey") else { return }
        
    }
    
    func getChampions() {
        
    }
}


struct GetChampionsRequest: SOLIDNetworking.Request {
    
    let apiKey: String
    
    // /api/lol/static-data/eune/v1.2/champion"
    // ["champData": "skins" as AnyObject, "api_key": apiKey as AnyObject]
    
    var httpMethod: HTTPMethod = .get
    var host: String = "global.api.pvp.net"
    var endpoint: String = "/api/lol/static-data/eune/v1.2/champion"
    
    var parameters: Parameters? { return ["champData": "skins", "api_key": apiKey] }
    var parameterEncoding: ParameterEncoding = JSONEncoding.default
    var headers: HTTPHeaders? = nil
    
    var interpreter = GetChampionsInterpreter()
}

class GetChampionsInterpreter: SOLIDNetworking.Interpreter {
    
    func interpret(data: Data?, response: HTTPURLResponse?, error: Error?) -> SOLIDNetworking.Result<[LoLChampion], ChampionsAPIError> {
        return Result.success([])
    }
    
    /*
 
 
 guard let data = json["data"].dictionary else { return nil }
 
 let champions = data.map({ (key: String, value: JSON) -> LoLChampion? in
 
 guard
 let name = value["name"].string,
 let championKey = value["key"].string
 else { return nil }
 
 return LoLChampion(name: name, key: championKey)
 
 }).flatMap({ $0 })
 
 return champions
 
 */
 
}

enum ChampionsAPIError: Error {
    case connection
}


struct LoLChampion {
    let name: String
    let key: String
}
