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
    func fetchChampions(_ callback:(([LoLChampion]?) -> ())?) {
        
        let apiKey: String? = plistStorage.readValue(forKey: "APIKey", inPlist: "APIKey")
        let championsRequest = ChampionsRequest(apiKey: apiKey)
        
        connectionEngine.performRequest(championsRequest) { [weak self] jsonResponse in

            guard case JSONResponse.success(let data) = jsonResponse else { callback?(nil); return }
            
            guard let champions = self?.interpreter.interpret(data) else { callback?(nil); return  }
            
            callback?(champions)
        }
    }
    
    // MARK: Dependencies
    
    fileprivate let plistStorage: PListStorage
    fileprivate let connectionEngine: ConnectionProtocol
    fileprivate let interpreter: ChampionsInterpreter
    
    init(plistStorage: PListStorage = PListStorage(),
         connectionEngine: ConnectionProtocol = AlamofireConnection(),
         interpreter: ChampionsInterpreter = ChampionsInterpreter()) {
        
        self.plistStorage = plistStorage
        self.connectionEngine = connectionEngine
        self.interpreter = interpreter
    }
}
