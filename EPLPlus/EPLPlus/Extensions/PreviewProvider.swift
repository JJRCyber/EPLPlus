//
//  PreviewProvider.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let match = Match(
        id: "436163",
        utcDate: Date(),
        status: "SCHEDULED",
        matchday: 23,
        lastUpdated: Date(),
        homeTeam: Team(id: "1044", name: "AFC Bournemouth", shortName: "Bournemouth", tla: "BOU", crest: "https://crests.football-data.org/1044.png"),
        awayTeam: Team(id: "351", name: "Nottingham Forest FC", shortName: "Nottingham", tla: "NOT", crest: "https://crests.football-data.org/351.png"),
        score: Result(winner: nil, duration: "REGULAR", fullTime: nil, halfTime: nil))
    
    let team = Team(id: "62", name: "Everton FC", shortName: "Everton", tla: "EVE", crest: "https://crests.football-data.org/62.png")
}
