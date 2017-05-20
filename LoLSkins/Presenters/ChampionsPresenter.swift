//
//  ChampionsPresenter.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 17/04/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol ChampionsPresenterSubscriber: class {
    func present(champions: [ChampionsVM])
    func show(error: ErrorVM)
}

class ChampionsPresenter {
    
    private weak var subscriber: ChampionsPresenterSubscriber!
    private let staticAPI: StaticDataAPI
    private let signal:  Signal<([LoLChampion], LoLVersion), NoError>
    
    init(subscriber: ChampionsPresenterSubscriber, staticAPI: StaticDataAPI = StaticDataAPI()) {
        self.subscriber = subscriber
        self.staticAPI = staticAPI
        
        signal = Signal.combineLatest(
            staticAPI.champions.signal.skipNil(),
            staticAPI.latestVersion.signal.skipNil())
        
        signal.observeValues { [unowned self] in
            let vm = self.convertToVM(champions: $0.0, version: $0.1)
            self.subscriber.present(champions: vm)
        }
        
        staticAPI.fetchChampions()
        staticAPI.fetchLatestVersion()
        
    }
    
    // MARK: Private
    
    private func convertToVM(champions: [LoLChampion], version: LoLVersion) -> [ChampionsVM] {
        
        return champions.map { champion in
            let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/champion/\(champion.key).png")!
            return ChampionsVM(key: champion.key, imageUrl: url)
        }
    }
    
    private func convertToVM(error: APIError) -> ErrorVM {
        return ErrorVM(title: "error", message: error.localizedDescription)
    }
}

struct ChampionsVM {
    
    let key: String
    let imageUrl: URL
}

struct ErrorVM {
    let title: String
    let message: String
}
