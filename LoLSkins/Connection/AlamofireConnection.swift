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
    
    func performRequest(_ request: Request, callback: ((JSONResponse) -> ())?) {
        
        Alamofire.request(request.endpoint, method: request.httpMethod, parameters: request.parameters, encoding: request.parametersEncoding, headers: nil)
            .validate()
            .responseData { response in
            
                if let json = response.result.value, response.result.isSuccess {
                    callback?(JSONResponse.success(json))
                } else {
                    callback?(JSONResponse.error("Failure response received"))
                }
        }
    }
}
