//
//  TeamsViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 21/9/2023.
//

import Foundation
import Combine

// View model for teams view
// Inherits from BaseViewModel
final class TeamsViewModel: BaseViewModel {
    
    // Published arrays for allTeams and favouriteTeams
    @Published var allTeams: [TeamDetail] = []
    @Published var favouriteTeams: [TeamDetail] = []
    
    // Stores cancellable downloads
    private var cancellables = Set<AnyCancellable>()
    
    // Override init
    override init() {
        super.init()
        addSubscribers()
        getTeams()
    }
    
    // Subscribes to teams publisher from footballDataManager
    func addSubscribers() {
        footballDataManager.$allTeams
            .map { teams in
                teams.sorted { $0.shortName < $1.shortName }
            }
            .sink { [weak self] sortedTeams in
                self?.allTeams = sortedTeams
            }
            .store(in: &cancellables)
    }
    
    // Retrieves teams from FootballDataManager
    private func getTeams() {
        footballDataManager.getTeams()
    }
}
