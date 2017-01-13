//
//  ConnectionProtocol.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import Foundation

protocol ConnectionProtocol {
    
    func performRequest(_ request: Request, callback: ((JSONResponse) -> ())?)
}
