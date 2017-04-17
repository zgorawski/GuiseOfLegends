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
        
        guard let apiKey = apiKey else { return }
        
        let request = GetChampionsRequest(apiKey: apiKey)
        engine.performRequest(request: request, handler: { _ in })
    }
    
    func getChampions() {
        
    }
    
    // MARK: Private
    
    private var apiKey: String? { return plistStorage.readValue(forKey: "APIKey", inPlist: "APIKey") }
}


struct GetChampionsRequest: SOLIDNetworking.Request {
    
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    // /api/lol/static-data/eune/v1.2/champion"
    // https://eun1.api.riotgames.com/lol/static-data/v3/champions?champData=skins&api_key=102aae41-5d53-49eb-ac7d-d21b4b9c9a2a
    
    var httpMethod: HTTPMethod { return .get }
    var host: String { return "eun1.api.riotgames.com" }
    var endpoint: String { return "/lol/static-data/v3/champions" }
    
    var parameters: Parameters? { return ["champData": "skins", "api_key": apiKey] }
    var parameterEncoding: ParameterEncoding { return URLEncoding.default }
    var headers: HTTPHeaders? { return nil }
    
    var interpreter: GetChampionsInterpreter = GetChampionsInterpreter()
}

class GetChampionsInterpreter: SOLIDNetworking.Interpreter {
    
    func interpret(data: Data?, response: HTTPURLResponse?, error: Error?) -> SOLIDNetworking.Result<[LoLChampion], ChampionsAPIError> {
        
        guard error == nil, response?.statusCode == 200, let data = data else {
            return Result.error(ChampionsAPIError.connection)
        }
        
        
        let json = JSON(data: data)
        
        guard let dataJson = json["data"].dictionary else { return Result.error(ChampionsAPIError.connection) }
        
        let champions = dataJson.map({ (key: String, value: JSON) -> LoLChampion? in
            
            guard
                let name = value["name"].string,
                let championKey = value["key"].string
                else { return nil }
            
            return LoLChampion(name: name, key: championKey)
            
        }).flatMap({ $0 })
        
        return Result.success(champions)
    }
}

enum ChampionsAPIError: Error {
    case connection
}


struct LoLChampion {
    let name: String
    let key: String
}
