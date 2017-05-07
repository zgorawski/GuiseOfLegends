//
//  VersionsRequest.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 07/05/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import SOLIDNetworking
import Alamofire

struct GetVersionsRequest: SOLIDNetworking.Request {
    
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    var httpMethod: HTTPMethod { return .get }
    var host: String { return "eun1.api.riotgames.com" }
    var endpoint: String { return "/lol/static-data/v3/versions" }
    
    var parameters: Parameters? { return nil }
    var parameterEncoding: ParameterEncoding { return URLEncoding.default }
    var headers: HTTPHeaders? { return nil }
    
    var interpreter: GetVersionsInterpreter = GetVersionsInterpreter()
}
