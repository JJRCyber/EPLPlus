//
//  Standings.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 21/9/2023.
//

import Foundation

// MARK: - Standings
struct Standings: Codable {
    let filters: Filters
    let season: Season
    let standings: [Standing]
}

// MARK: - Standing
struct Standing: Codable {
    let table: [Table]
}

// MARK: - Table
struct Table: Codable {
    let position: Int
    let team: Team
    let playedGames: Int
    let won, draw, lost, points: Int
    let goalsFor, goalsAgainst, goalDifference: Int
}
