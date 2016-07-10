//
//  ChampionsController.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import Foundation

class  ChampionsController {
    
    // MARK: API
    
    func getCachedChampions() -> [LoLChampion] {
        return []
    }
    
    //
    // callback has nil as parameter value in case of error
    // can be replaced with custom Success/Error type if more information would be required
    func fetchChampions(callback:(([LoLChampion]?) -> ())?) {
        
        let apiKey: String? = plistStorage.readValue(forKey: "apiKey", inPlist: "APIKey")
        let championsRequest = ChampionsRequest(apiKey: apiKey)
        
        connectionEngine.performRequest(championsRequest) { jsonResponse in
            
            // TODO: interpret response if success
        }
    }
    
    // MARK: Dependencies
    
    private let plistStorage: PListStorage
    private let connectionEngine: ConnectionProtocol
    
    init(plistStorage: PListStorage = PListStorage(),
         connectionEngine: ConnectionProtocol = AlamofireConnection()) {
        
        self.plistStorage = plistStorage
        self.connectionEngine = connectionEngine
    }
}