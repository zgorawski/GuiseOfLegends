//
//  AlamofireConnection.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AlamofireConnection: ConnectionProtocol {
    
    func performRequest(_ request: Request, callback: ((JSONResponse) -> ())?) {
        
        
        Alamofire.request(
            request.endpoint,
            method: request.httpMethod,
            parameters: request.parameters,
            encoding: request.parametersEncoding,
            headers: nil)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    callback?(JSONResponse.success(json))
                case .failure(let error):
                    callback?(JSONResponse.error("Failure response received \(error.localizedDescription)"))
                }

        }
    }
}
