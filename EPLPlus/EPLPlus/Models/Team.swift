//
//  TeamDetail.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 21/9/2023.
//

import Foundation

// Contains array of TeamDetail
struct Teams: Codable {
    let teams: [TeamDetail]
}

// Team detail struct for use in team information page
struct TeamDetail: Identifiable, Codable {
    let id: Int
    let name, shortName, tla: String
    let crest: String
    let address: String
    let website: String
    let founded: Int?
    let clubColors, venue: String
    let coach: Coach
    let squad: [Player]
}

// Basic team struct that is used when displaying teams in lists
struct Team: Identifiable, Codable {
    let id: Int
    let name, shortName, tla: String
    let crest: String
    
    // Custom init from TeamDetail struct
    init(teamDetail: TeamDetail) {
        self.id = teamDetail.id
        self.name = teamDetail.name
        self.shortName = teamDetail.shortName
        self.tla = teamDetail.tla
        self.crest = teamDetail.crest
    }
    
    // Default init
    init(id: Int, name: String, shortName: String, tla: String, crest: String) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.tla = tla
        self.crest = crest
    }
}

// Struct for coach
struct Coach: Codable {
    let id: Int
    let name: String
    let nationality: String
}

// Struct for player
struct Player: Identifiable, Codable {
    let id: Int
    let name: String
    let position: String?
    let nationality: String
}
