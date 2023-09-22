//
//  TeamsViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 21/9/2023.
//

import Foundation
import Combine

final class TeamsViewModel: ObservableObject {
    
    @Published var allTeams: [Team] = []
    @Published var favouriteTeams: [Team] = []
    
    private let standingsManager = StandingsManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        standingsManager.$allTeams
            .map { teams in
                teams.sorted { $0.shortName < $1.shortName }
            }
            .sink { [weak self] sortedTeams in
                self?.allTeams = sortedTeams
            }
            .store(in: &cancellables)
    }
}
