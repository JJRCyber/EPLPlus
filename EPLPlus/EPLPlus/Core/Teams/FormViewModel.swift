//
//  FormViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 2/10/2023.
//

import Foundation


final class FormViewModel: BaseViewModel {
    
    @Published var leaguePosition: LeaguePosition?
    //@Published var leaguePosition = LeaguePosition(position: 3, team: Team(id: 62, name: "Everton", shortName: "Everton", tla: "EVE", crest: ""), playedGames: 5, won: 4, draw: 1, lost: 1, points: 45, goalsFor: 23, goalsAgainst: 30, goalDifference: -7)

    
    let teamId: Int
    
    init(teamId: Int) {
        self.teamId = teamId
        super.init()
        getLeaguePosition()
    }
    
    
    private func getLeaguePosition() {
        if let matchingPosition = footballDataManager.standings.first(where: { $0.team.id == self.teamId }) {
            self.leaguePosition = matchingPosition
        }
    }

}
