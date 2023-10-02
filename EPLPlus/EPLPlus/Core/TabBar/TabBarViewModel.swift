//
//  TabBarViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import Combine

// Inherits from BaseViewModel
final class TabBarViewModel: BaseViewModel {
    
    // Published array of leaguepositions and Int for currentMatchDay
    @Published var standings: [LeaguePosition] = []
    @Published var currentMatchDay: Int = 1
    
    // Stores cancellable downloads
    private var cancellables = Set<AnyCancellable>()
    
    // override init
    override init() {
        super.init()
        addSubscribers()
        getStandings()
    }
    
    // Adds subscribers for footballDataManager publishers
    // Weak self used incase view is deinit while downloading
    func addSubscribers() {
        footballDataManager.$standings
            .sink { [weak self] standings in
                self?.standings = standings
            }
            .store(in: &cancellables)
        footballDataManager.$currentMatchDay
            .sink { [weak self] currentMatchDay in
                self?.currentMatchDay = currentMatchDay
            }
            .store(in: &cancellables)
    }
    
    // Updates standings from API
    private func getStandings() {
        footballDataManager.getStandings()
    }
    
    
}
