//
//  Result.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 17/04/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

enum Result<T, E: Error> {
    
    case success(T)
    case error(E)
}
