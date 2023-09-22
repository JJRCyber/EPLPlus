//
//  StandingsManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import Combine

class StandingsManager {
    
    private let apiKey = "a0d0864a57a7411193ae93133a296507"
    
    @Published var allTeams: [Team] = []
    @Published var standings: [LeaguePosition] = []
    var standingsSubscription: AnyCancellable?
    
    init() {
        getStandings()
    }
    
    // Function to retrieve standings from API using combine
    private func getStandings() {
        // Setup url and HTTP headers as outlined on https://docs.football-data.org/general/v4/competition.html
        guard let url = URL(string: "https://api.football-data.org/v4/competitions/PL/standings") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        standingsSubscription = NetworkingManager.download(request: request)
            .decode(type: LeagueTable.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] leagueTableResponse in
                let table = leagueTableResponse.standings[0].table
                var currentTeams: [Team] = []
                self?.standings = table
                for standing in table {
                    currentTeams.append(standing.team)
                }
                self?.allTeams = currentTeams
                self?.standingsSubscription?.cancel()
            })

    }
}
