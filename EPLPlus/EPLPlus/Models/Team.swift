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
}

// MARK: - Team
struct Team: Identifiable, Codable {
    let id: Int
    let name, shortName, tla: String
    let crest: String
    
    init(teamDetail: TeamDetail) {
        self.id = teamDetail.id
        self.name = teamDetail.name
        self.shortName = teamDetail.shortName
        self.tla = teamDetail.tla
        self.crest = teamDetail.crest
    }
    
    init(id: Int, name: String, shortName: String, tla: String, crest: String) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.tla = tla
        self.crest = crest
    }
}

// MARK: - Coach
struct Coach: Codable {
    let id: Int
    let name: String
    let nationality: String
}

// MARK: - Squad
struct Squad: Identifiable, Codable {
    let id: Int
    let name: String
    let position: String?
    let nationality: String
}
