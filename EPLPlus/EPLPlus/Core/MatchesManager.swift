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
    private func getMatches(matchday: Int) {
        // Setup url and HTTP headers as outlined on https://docs.football-data.org/general/v4/competition.html
        guard let url = URL(string: "https://api.football-data.org/v4/competitions/PL/matches?matchday=\(matchday)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        // Create a URL session with a publisher so we can subscribe to changes
        // Assign to standingsSubcription so we can cancel if we need to
        matchesSubscription = URLSession.shared.dataTaskPublisher(for: request)
            // Subscribe on background thread for data downloading
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
//                print(String(data: output.data, encoding: .utf8))
                // Check that response code is within OK range
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            // Recieve data on main thread as we are updating the UI
            .receive(on: DispatchQueue.main)
            // Try decode from JSON to Standings model
            .decode(type: Matchday.self, decoder: JSONDecoder())
            // Switch on completion, if error print out the error
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            // Set self.standings to standings response
            // Using weak self so the viewModel object does not remain alive if user navigates away form view before completion
            // Once data downloaded cancel the publisher
            } receiveValue: { [weak self] (matchdayResponse) in
                self?.matches = matchdayResponse.matches
                self?.matchesSubscription?.cancel()
            }

    }
}
