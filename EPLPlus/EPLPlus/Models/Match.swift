//
//  Match.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import Foundation

// Struct that API response decodes into
// Array of matches is the most important component
struct Matchday: Codable {
    let filters: Filters
    let resultSet: ResultSet
    let matches: [Match]
}

// Values for matchday of request and season
// Will always be current season
struct Filters: Codable {
    let season, matchday: String
}

// Match struct for displaying on  matches page
struct Match: Identifiable, Codable {
    let id: Int
    let utcDate: Date
    let status: String
    let matchday: Int
    let lastUpdated: Date
    let homeTeam, awayTeam: Team
    let score: Result
}

// Result is only set once match complete
struct Result: Codable {
    let winner: String?
    let fullTime, halfTime: Score
}

// Score struct - values set to nil before game has begun
struct Score: Codable {
    let home, away: Int?
}

/* Result set for match day
- How many games scheduled
- How many have been played at current time
- Date of first played game
- Date of last played game
 */
struct ResultSet: Codable {
    let count: Int
    let first, last: String
    let played: Int
}
