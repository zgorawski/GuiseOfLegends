//
//  SkinsPresenter.swift
//  LoLSkins
//
//  Created by Zbigniew Górawski on 28/05/2017.
//  Copyright © 2017 Zbigniew Górawski. All rights reserved.
//

import Foundation

class SkinsPresenter {
    
    private(set) var viewModel: [SkinVM]
    
    init(champion: LoLChampion) {
        
        viewModel = champion.skins.map { skin in
            return SkinVM(
                name: skin.name,
                portraitUrl: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(champion.key)_\(skin.num).jpg")!,
                splashUrl: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champion.key)_\(skin.num).jpg")!)
        }
    }
    
}

struct SkinVM {
    let name: String
    let portraitUrl: URL
    let splashUrl: URL
}
