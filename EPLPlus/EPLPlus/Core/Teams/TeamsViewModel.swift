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
    
    // Reference to favouriteTeamManager
    private let favouriteTeamManager = FavouriteTeamsManager()
    
    // Published arrays for allTeams and favouriteTeams
    @Published var allTeams: [TeamDetail] = []
    @Published var favouriteTeams: [TeamDetail] = []
    
    // Variables for when user selects team on list
    @Published var selectedTeam: TeamDetail?
    @Published var showTeamDetailView: Bool = false
    
    // Toggle between all teams and favourite teams lists
    @Published var showFavourites: Bool = false
    
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
        // Updates all teams and sorts them alphabetically
        footballDataManager.$allTeams
            .map { teams in
                teams.sorted { $0.shortName < $1.shortName }
            }
            .sink { [weak self] sortedTeams in
                self?.allTeams = sortedTeams
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        // Filters all teams list to favourite teams list based on what is stored in CoreData
        // This allows teamDetailView to load instantly without another API request
        $allTeams
            .combineLatest(favouriteTeamManager.$favouriteTeams)
            .map { (teamDetails, teamDetailEntitys) -> [TeamDetail] in
                teamDetails
                    .compactMap { (team) -> TeamDetail? in
                        guard teamDetailEntitys.first(where: { $0.id == team.id }) != nil else {
                        return nil
                    }
                    return team
                }
            }
            .sink { [weak self] returnedTeams in
                self?.favouriteTeams = returnedTeams
            }
            .store(in: &cancellables)
    }
    
    // Retrieves teams from FootballDataManager
    private func getTeams() {
        isLoading = true
        footballDataManager.getTeams()
    }
    
    // Returns whether a team is favourited or not
    func isFavouriteTeam(team: TeamDetail) -> Bool {
        return favouriteTeams.contains(where: {$0.id == team.id})
    }
    
    // Triggers team detail view when team selected
    func viewSegue(teamDetail: TeamDetail) {
        selectedTeam = teamDetail
        showTeamDetailView.toggle()
    }
    
    // Toggles team favourite status on button press
    func toggleTeamFavourite(team: TeamDetail) {
        if let index = favouriteTeams.firstIndex(where: {$0.id == team.id}) {
            favouriteTeams.remove(at: index)
            favouriteTeamManager.removeTeamFromFavourites(team: team)
        } else {
            favouriteTeams.append(team)
            favouriteTeamManager.addTeamToFavourites(team: team)
        }
    }
}
