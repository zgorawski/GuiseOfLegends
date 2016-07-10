//
//  JSONResponse.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 10.07.2016.
//  Copyright © 2016 Zbigniew Górawski. All rights reserved.
//

import Foundation

enum JSONResponse {
    case Success(NSData)
    case Error(String)
}