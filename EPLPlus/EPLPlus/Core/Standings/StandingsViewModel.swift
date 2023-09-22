//
//  StandingsViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import Combine


final class StandingsViewModel: BaseViewModel {
    
    @Published var standings: [LeaguePosition] = []
    @Published var currentMatchDay = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        addSubscribers()
        getStandings()
    }
    
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
    
    private func getStandings() {
        footballDataManager.getStandings()
    }
}
