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
    
    // Variables for when user selects team on list
    @Published var selectedTeam: TeamDetail?
    @Published var showTeamDetailView: Bool = false
    
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
    
    func isFavouriteTeam(team: TeamDetail) -> Bool {
        return favouriteTeams.contains(where: {$0.id == team.id})
    }
    
    func toggleTeamFavourite(team: TeamDetail) {
        if let index = favouriteTeams.firstIndex(where: {$0.id == team.id}) {
            favouriteTeams.remove(at: index)
        } else {
            favouriteTeams.append(team)
        }
    }
}
