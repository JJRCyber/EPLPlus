//
//  StandingsViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import Combine


final class StandingsViewModel: ObservableObject {
    
    @Published var standings: [LeaguePosition] = []
    
    private let standingsManager = StandingsManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        standingsManager.$standings
            .sink { [weak self] standings in
                self?.standings = standings
            }
            .store(in: &cancellables)
    }
}
