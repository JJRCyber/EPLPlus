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
    }
    
    private func getStandings() {
        footballDataManager.getStandings()
    }
}
