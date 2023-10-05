//
//  StandingsManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import Combine

/*
 Manages all API request from https://www.football-data.org
 Documentation for API can be viewed here: https://docs.football-data.org/general/v4/resources.html
 Currently uses these endpoints to retrieve standings, teams and matchday information:
 - https://api.football-data.org/v4/competitions/PL/standings
 - https://api.football-data.org/v4/competitions/PL/teams
 - https://docs.football-data.org/general/v4/competitions/PL/matches?matchday=x
 All information is for current English Premier League season
 Singleton instance that is accessed by viewModels
 */

final class FootballDataAPIManager {
    
    static let instance = FootballDataAPIManager()
    private init() { }
    
    // Hardcoded API key - free plan allows for 10 requests per minute
    private let apiKey = "a0d0864a57a7411193ae93133a296507"
    
    // Published arrays for Teams, League standings, Matches and Int to store current match day
    @Published var allTeams: [TeamDetail] = []
    @Published var standings: [LeaguePosition] = []
    @Published var matches: [Match] = []
    @Published var currentMatchDay: Int = 0
    
    // Allows cancellation of API requests while downloading
    var standingsSubscription: AnyCancellable?
    var matchesSubscription: AnyCancellable?
    var teamsSubscription: AnyCancellable?
    
    // Function to retrieve standings from API using combine
    func getStandings() {
        print("Downloading Standings")
        guard let url = URL(string: "https://api.football-data.org/v4/competitions/PL/standings") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Sets API key in header
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        standingsSubscription = NetworkingManager.download(request: request)
        // Decondes to LeagueTable struct
            .decode(type: LeagueTable.self, decoder: JSONDecoder())
        // Use of weak self to to prevent object being kept alive if not needed
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] leagueTableResponse in
                // Sets standings array to returned league table
                self?.standings = leagueTableResponse.standings[0].table
                // Sets currentMatchDay to response value
                self?.currentMatchDay = leagueTableResponse.season.currentMatchday
                // Cancels the subscription as no more data will be returned
                self?.standingsSubscription?.cancel()
            })
    }
    
    // Function to retrieve teams from API using combine
    func getTeams() {
        print("Downloading Teams")
        guard let url = URL(string: "https://api.football-data.org/v4/competitions/PL/teams") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Sets API key in header
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        teamsSubscription = NetworkingManager.download(request: request)
        // Decode as Teams struct
            .decode(type: Teams.self, decoder: JSONDecoder())
        // Use of weak self to to prevent object being kept alive if not needed
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] teamsResponse in
                // Set allTeams to response teams
                self?.allTeams = teamsResponse.teams
                // Cancel subscription as no more data will be returned
                self?.teamsSubscription?.cancel()
            })
    }
    
    // Function to retrieve matches for a specified matchday from API using combine
    func getMatches(matchday: Int) {
        print("Downloading Matches")
        guard let url = URL(string: "https://api.football-data.org/v4/competitions/PL/matches?matchday=\(matchday)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Sets API key in header
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        // Explicitly set decoder and date decoding strategy
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        matchesSubscription = NetworkingManager.download(request: request)
        // Decode as matchday struct
            .decode(type: Matchday.self, decoder: decoder)
        // Use of weak self to to prevent object being kept alive if not needed
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] matchesResponse in
                // Set matches to response matches
                self?.matches = matchesResponse.matches
                // Cancel subscription as no more data will be returned
                self?.matchesSubscription?.cancel()
            })
    }
}
