//
//  Standings.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 21/9/2023.
//

import Foundation

// Struct for league table
struct LeagueTable: Codable {
    let season: Season
    let standings: [Standing]
}

// Struct for season
struct Season: Codable {
    let id: Int
    let startDate, endDate: String
    let currentMatchday: Int
}

// Contains actual table object with leaguepositions
struct Standing: Codable {
    let table: [LeaguePosition]
}

// League position struct with information on team at each position
struct LeaguePosition: Identifiable, Codable {
    let id: Int
    let position: Int
    let team: Team
    let playedGames: Int
    let won, draw, lost, points: Int
    let goalsFor, goalsAgainst, goalDifference: Int
    
    // Custom init from decoder as API response does not contain ID
    // ID is required to conform to identifiable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.position = try container.decode(Int.self, forKey: .position)
        self.id = self.position
        self.team = try container.decode(Team.self, forKey: .team)
        self.playedGames = try container.decode(Int.self, forKey: .playedGames)
        self.won = try container.decode(Int.self, forKey: .won)
        self.draw = try container.decode(Int.self, forKey: .draw)
        self.lost = try container.decode(Int.self, forKey: .lost)
        self.points = try container.decode(Int.self, forKey: .points)
        self.goalsFor = try container.decode(Int.self, forKey: .goalsFor)
        self.goalsAgainst = try container.decode(Int.self, forKey: .goalsAgainst)
        self.goalDifference = try container.decode(Int.self, forKey: .goalDifference)
    }
    
    // Default init from passed parameters
    init(position: Int, team: Team, playedGames: Int, won: Int, draw: Int, lost: Int, points: Int, goalsFor: Int, goalsAgainst: Int, goalDifference: Int) {
        self.id = position
        self.position = position
        self.team = team
        self.playedGames = playedGames
        self.won = won
        self.draw = draw
        self.lost = lost
        self.points = points
        self.goalsFor = goalsFor
        self.goalsAgainst = goalsAgainst
        self.goalDifference = goalDifference
    }
}


