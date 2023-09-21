//
//  Fixture.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import Foundation

// Fixture API Info
/*
 URL: https://api.football-data.org/v4/competitions/PL/matches?matchday=23
 API Key: a0d0864a57a7411193ae93133a296507
 */

// MARK: - Matchday
struct Matchday: Codable {
    let filters: Filters
    let resultSet: ResultSet?
    let matches: [Match]
}

// MARK: - Filters
struct Filters: Codable {
    let season, matchday: String
}

// MARK: - Match
struct Match: Identifiable, Codable {
    let id: String
    let utcDate: Date
    let status: String
    let matchday: Int
    let lastUpdated: Date?
    let homeTeam, awayTeam: Team
    let score: Result?
}

// MARK: - Team
struct Team: Codable {
    let id: String
    let name, shortName, tla: String
    let crest: String
}

// MARK: - Score
struct Result: Codable {
    let winner: String?
    let duration: String
    let fullTime, halfTime: Score?
}

// MARK: - Time
struct Score: Codable {
    let home, away: Int?
}

// MARK: - Season
struct Season: Codable {
    let id: String
    let startDate, endDate: String?
    let currentMatchday: Int?
}

// MARK: - ResultSet
struct ResultSet: Codable {
    let count: Int?
    let first, last: String?
    let played: Int?
}
