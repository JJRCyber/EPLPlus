//
//  MatchesManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import Combine

final class MatchesManager {
    
    private let apiKey = "a0d0864a57a7411193ae93133a296507"
    
    @Published var matches: [Match] = []
    var matchesSubscription: AnyCancellable?
    
    // Function to retrieve standings from API using combine
    func getMatches(matchday: Int) {
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
