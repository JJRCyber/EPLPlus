//
//  StandingsManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import Combine

class FootballDataAPIManager {
    
    static let instance = FootballDataAPIManager()
    private init() { }
    
    private let apiKey = "a0d0864a57a7411193ae93133a296507"
    
    @Published var allTeams: [TeamDetail] = []
    @Published var standings: [LeaguePosition] = []
    @Published var matches: [Match] = []
    var standingsSubscription: AnyCancellable?
    var matchesSubscription: AnyCancellable?
    var teamsSubscription: AnyCancellable?
    
    // Function to retrieve standings from API using combine
    func getStandings() {
        print("Downloading Standings")
        // Setup url and HTTP headers as outlined on https://docs.football-data.org/general/v4/competition.html
        guard let url = URL(string: "https://api.football-data.org/v4/competitions/PL/standings") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        standingsSubscription = NetworkingManager.download(request: request)
            .decode(type: LeagueTable.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] leagueTableResponse in
                let table = leagueTableResponse.standings[0].table
                self?.standings = table
                self?.standingsSubscription?.cancel()
            })
    }
    
    // Function to retrieve standings from API using combine
    func getTeams() {
        print("Downloading Teams")
        // Setup url and HTTP headers as outlined on https://docs.football-data.org/general/v4/competition.html
        guard let url = URL(string: "https://api.football-data.org/v4/competitions/PL/teams") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        teamsSubscription = NetworkingManager.download(request: request)
            .decode(type: Teams.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] teamsResponse in
                self?.allTeams = teamsResponse.teams
                self?.teamsSubscription?.cancel()
            })
    }
    
    // Function to retrieve standings from API using combine
    func getMatches(matchday: Int) {
        print("Downloading Matches")
        // Setup url and HTTP headers as outlined on https://docs.football-data.org/general/v4/competitions/PL/matches?matchday=23
        guard let url = URL(string: "https://api.football-data.org/v4/competitions/PL/matches?matchday=\(matchday)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        matchesSubscription = NetworkingManager.download(request: request)
            .decode(type: Matchday.self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] matchesResponse in
                self?.matches = matchesResponse.matches
                self?.matchesSubscription?.cancel()
            })
    }
}
