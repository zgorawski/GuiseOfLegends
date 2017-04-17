//
//  GetChampions.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 16/04/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import SOLIDNetworking
import Alamofire
import SwiftyJSON

class ChampionsAPI {
    
    private let engine: NetworkingEngine
    private let plistStorage: PListStorage
    
    init(plistStorage: PListStorage = PListStorage(), engine: NetworkingEngine = NetworkingEngine()) {
        self.plistStorage = plistStorage
        self.engine = engine
    }
    
    // MARK: Cache
    
    private static var champions: [LoLChampion]? = nil
    
    // MARK: API
    
    func fetchChampions(handler: @escaping (Result<[LoLChampion], ChampionsAPIError>) -> Void) {
        
        guard let apiKey = apiKey else { return }
        
        let request = GetChampionsRequest(apiKey: apiKey)
        engine.performRequest(request: request) { result in
            
            switch result {
            case .success(let champions):
                ChampionsAPI.champions = champions
                handler(.success(champions))
            case .error(let error):
                handler(.error(error))
            }
            
        }
    }
    
    func getChampions() -> [LoLChampion]? {
        return ChampionsAPI.champions
    }
    
    // MARK: Private
    
    private var apiKey: String? { return plistStorage.readValue(forKey: "APIKey", inPlist: "APIKey") }
}


struct GetChampionsRequest: SOLIDNetworking.Request {
    
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
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
            return SOLIDNetworking.Result.error(ChampionsAPIError.connection)
        }
        
        let json = JSON(data: data)
        
        guard let dataJson = json["data"].dictionary else { return SOLIDNetworking.Result.error(ChampionsAPIError.connection) }
        
        let champions = dataJson.map({ (key: String, value: JSON) -> LoLChampion? in
            
            guard
                let name = value["name"].string,
                let championKey = value["key"].string
                else { return nil }
            
            return LoLChampion(name: name, key: championKey)
            
        }).flatMap({ $0 })
        
        return SOLIDNetworking.Result.success(champions)
    }
}

enum ChampionsAPIError: Error {
    case connection
}


struct LoLChampion {
    let name: String
    let key: String
}
