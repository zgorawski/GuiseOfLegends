//
//  RequestProtocol.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import Alamofire

protocol Request {

    var endpoint: String { get }
    var httpMethod: Alamofire.HTTPMethod { get }
    var parameters: [String: AnyObject]? { get }
    var parametersEncoding: Alamofire.ParameterEncoding { get }
}

extension Request {
    
    var parameters: [String: AnyObject]? {
        return nil
    }
    
    var parametersEncoding: Alamofire.ParameterEncoding {
        return Alamofire.URLEncoding.default
    }
}
