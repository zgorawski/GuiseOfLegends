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
    
    let latestVersion = MutableProperty<[ChampionsVM]?>(nil)
    
    private weak var subscriber: ChampionsPresenterSubscriber!
    private let staticAPI: StaticDataAPI
    private let producer:  SignalProducer<([LoLChampion], LoLVersion), NoError>
    
    init(subscriber: ChampionsPresenterSubscriber, staticAPI: StaticDataAPI = DIContainer.shared.staticDataAPI) {
        self.subscriber = subscriber
        self.staticAPI = staticAPI
        
        producer = SignalProducer.combineLatest(
            staticAPI.champions.producer.skipNil(),
            staticAPI.latestVersion.producer.skipNil())
        
        producer.startWithValues { [weak self] (champions, varsion) in
            guard let vm = self?.convertToVM(champions: champions, version: varsion) else { return }
            self?.latestVersion.value = vm
            self?.subscriber.present(champions: vm)
        }
        
        // TODO: Observe errors
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
