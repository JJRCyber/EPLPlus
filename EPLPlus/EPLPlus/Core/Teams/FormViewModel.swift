//
//  FormViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 2/10/2023.
//

import Foundation

// Viewmodel to lookup form of given team ID
final class FormViewModel: BaseViewModel {
    
    @Published var leaguePosition: LeaguePosition?

    
    let teamId: Int
    
    init(teamId: Int) {
        self.teamId = teamId
        super.init()
        getLeaguePosition()
    }
    
    // Gets league position information for given team
    private func getLeaguePosition() {
        if let matchingPosition = footballDataManager.standings.first(where: { $0.team.id == self.teamId }) {
            self.leaguePosition = matchingPosition
        }
    }

}
