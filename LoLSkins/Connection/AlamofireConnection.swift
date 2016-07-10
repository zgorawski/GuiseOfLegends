//
//  AlamofireConnection.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireConnection: ConnectionProtocol {
    
    func performRequest(request: Request, callback: ((JSONResponse) -> ())?) {
        
        Alamofire.request(request.httpMethod, request.endpoint, parameters: request.parameters, encoding: request.parametersEncoding, headers: nil)
            .validate()
            .responseJSON { response in
            
                if let json = response.result.value where response.result.isSuccess {
                    callback?(JSONResponse.Success(json))
                } else {
                    callback?(JSONResponse.Error("Failure response received"))
                }
        }
    }
}