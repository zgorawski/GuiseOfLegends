//
//  VersionsInterpreter.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 07/05/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import SOLIDNetworking
import SwiftyJSON

class GetVersionsInterpreter: SOLIDNetworking.Interpreter {
    
    func interpret(data: Data?, response: HTTPURLResponse?, error: Error?) -> SOLIDNetworking.Result<LoLVersion, APIError> {
        
        guard error == nil, response?.statusCode == 200, let data = data else {
            return SOLIDNetworking.Result.error(APIError.connection)
        }
        
        let json = JSON(data: data)
        
        guard let latestVersion = json.array?.first?.string else { return SOLIDNetworking.Result.error(APIError.connection) }
        
        return SOLIDNetworking.Result.success(latestVersion)
    }
}


typealias LoLVersion = String
