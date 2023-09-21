//
//  TeamDetail.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 21/9/2023.
//

import Foundation

// MARK: - Team
struct TeamDetail: Identifiable, Codable {
    let id: String
    let name, shortName, tla: String
    let crest: String
    let address: String
    let website: String
    let founded: String
    let clubColors, venue: String
    let lastUpdated: Date
}
