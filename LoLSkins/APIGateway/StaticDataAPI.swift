//
//  StaticDataAPI.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 07/05/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import SOLIDNetworking

class StaticDataAPI {
    
    private let engine: NetworkingEngine
    private let plistStorage: PListStorage
    
    init(plistStorage: PListStorage = PListStorage(), engine: NetworkingEngine = NetworkingEngine()) {
        self.plistStorage = plistStorage
        self.engine = engine
    }
    
    // MARK: Cache
    
    private static var champions: [LoLChampion]? = nil
    private static var latestVersion: LoLVersion? = nil
    
    // MARK: API
    
    func fetchChampions(handler: @escaping (Result<[LoLChampion], APIError>) -> Void) {
        
        guard let apiKey = apiKey else { return }
        
        let request = GetChampionsRequest(apiKey: apiKey)
        engine.performRequest(request: request) { result in
            
            switch result {
            case .success(let champions):
                StaticDataAPI.champions = champions
                handler(.success(champions))
            case .error(let error):
                handler(.error(error))
            }
            
        }
    }
    
    func getChampions() -> [LoLChampion]? {
        return StaticDataAPI.champions
    }
    
    
    func fetchLatestVersion(handler: @escaping (Result<LoLVersion, APIError>) -> Void) {
        
    }
    
    func getLatestVersion() -> LoLVersion? {
        return StaticDataAPI.latestVersion
    }
    
    // MARK: Private
    
    private var apiKey: String? { return plistStorage.readValue(forKey: "APIKey", inPlist: "APIKey") }
}
