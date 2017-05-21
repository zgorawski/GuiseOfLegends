//
//  DIContainer.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 21/05/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

final class DIContainer {
    
    lazy private(set) var staticDataAPI: StaticDataAPI = StaticDataAPI()
    
    // singleton stuff
    static let shared = DIContainer()
    private init() {}
}
