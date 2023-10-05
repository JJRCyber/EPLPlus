//
//  PreviewProvider.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import Foundation
import SwiftUI

// Extends PreviewProvider for creation of objects to be used when previewing views
extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let tabBarViewModel = StandingsViewModel()
    
    let match = Match(
        id: 436163,
        utcDate: Date(),
        status: "SCHEDULED",
        matchday: 23,
        lastUpdated: Date(),
        homeTeam: Team(id: 1044, name: "AFC Bournemouth", shortName: "Bournemouth", tla: "BOU", crest: "https://crests.football-data.org/1044.png"),
        awayTeam: Team(id: 351, name: "Nottingham Forest FC", shortName: "Nottingham", tla: "NOT", crest: "https://crests.football-data.org/351.png"),
        score: Result(winner: nil, fullTime: Score(home: nil, away: nil), halfTime: Score(home: nil, away: nil)))
    
    let team = Team(id: 62, name: "Everton FC", shortName: "Everton", tla: "EVE", crest: "https://crests.football-data.org/62.png")
    let teamDetail = TeamDetail(id: 62, name: "Everton FC", shortName: "Everton", tla: "EVE", crest: "https://crests.football-data.org/62.png", address: "Goodison Park Liverpool L4 4EL", website: "http://www.evertonfc.com", founded: 1878, clubColors: "Blue / White", venue: "Goodison Park", coach: Coach(id: 11584, name: "Sean Dyche", nationality: "England"), squad: [])
    
    let leaguePosition = LeaguePosition(position: 1, team: Team(id: 62, name: "Everton FC", shortName: "Everton", tla: "EVE", crest: "https://crests.football-data.org/62.png"), playedGames: 10, won: 8, draw: 1, lost: 1, points: 25, goalsFor: 30, goalsAgainst: 10, goalDifference: 20)
}
