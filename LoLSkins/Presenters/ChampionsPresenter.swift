//
//  ChampionsPresenter.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 17/04/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import Foundation

protocol ChampionsPresenterSubscriber: class {
    func present(champions: [ChampionsVM])
    func show(error: ErrorVM)
}

class ChampionsPresenter {
    
    private weak var subscriber: ChampionsPresenterSubscriber!
    private let championsAPI: ChampionsAPI
    
    init(subscriber: ChampionsPresenterSubscriber, championsAPI: ChampionsAPI = ChampionsAPI()) {
        self.subscriber = subscriber
        self.championsAPI = championsAPI
        
        refreshChampions()
    }
    
    // MARK: API
    
    func refreshChampions() {
        
        if let model = championsAPI.getChampions() {
            let vm = convertToVM(model: model)
            subscriber.present(champions: vm)
        } else {
            
            championsAPI.fetchChampions { [unowned self] result in
                
                switch result {
                case .success(let model):
                    let vm = self.convertToVM(model: model)
                    self.subscriber.present(champions: vm)
                case .error(let error):
                    let vm = self.convertToVM(error: error)
                    self.subscriber.show(error: vm)
                }
            }
        }
    }
    
    // MARK: Private
    
    private func convertToVM(model: [LoLChampion]) -> [ChampionsVM] {
        return model.map { champion in
            
            let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/7.7.1/img/champion/\(champion.key).png")!
            return ChampionsVM(key: champion.key, imageUrl: url)
        }
    }
    
    private func convertToVM(error: ChampionsAPIError) -> ErrorVM {
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