//
//  StaticDataAPI.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 07/05/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import SOLIDNetworking
import ReactiveSwift

class StaticDataAPI {
    
    private let engine: NetworkingEngine
    private let plistStorage: PListStorage
    
    init(plistStorage: PListStorage = PListStorage(), engine: NetworkingEngine = NetworkingEngine()) {
        self.plistStorage = plistStorage
        self.engine = engine
        
        // warm up
        fetchChampions()
        fetchLatestVersion()
    }

    // MARK: Rx
    
    let champions = MutableProperty<[LoLChampion]?>(nil)
    let latestVersion = MutableProperty<LoLVersion?>(nil)
    let error = MutableProperty<APIError?>(nil)
    
    // MARK: API
    
    func fetchChampions() {
        
        guard let apiKey = apiKey else { return }
        
        let request = GetChampionsRequest(apiKey: apiKey)
        engine.performRequest(request: request) { [weak self] result in
            
            switch result {
            case .success(let champions):
                self?.champions.value = champions
            case .error(let error):
                self?.error.value = error
            }
        }
    }
    
    func fetchLatestVersion() {
        
        guard let apiKey = apiKey else { return }
        
        let request = GetVersionsRequest(apiKey: apiKey)
        engine.performRequest(request: request) { [weak self] result in
            
            switch result {
            case .success(let version):
                self?.latestVersion.value = version
            case .error(let error):
                self?.error.value = error
            }
        }
    }
    
    
    // MARK: Private
    
    private var apiKey: String? { return plistStorage.readValue(forKey: "APIKey", inPlist: "APIKey") }
}
