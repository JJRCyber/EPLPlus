//
//  TeamDetail.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 21/9/2023.
//

import Foundation

// MARK: - Teams
struct Teams: Codable {
    let teams: [TeamDetail]
}

// MARK: - Team
struct TeamDetail: Identifiable, Codable {
    let id: Int
    let name, shortName, tla: String
    let crest: String
    let address: String
    let website: String
    let founded: Int?
    let clubColors, venue: String
    let coach: Coach
    let squad: [Squad]
    let lastUpdated: Date
}

// MARK: - Coach
struct Coach: Codable {
    let id: Int
    let firstName, lastName, name, dateOfBirth: String
    let nationality: String
}

// MARK: - Squad
struct Squad: Identifiable, Codable {
    let id: Int
    let name: String
    let position: String?
    let nationality: String
}
