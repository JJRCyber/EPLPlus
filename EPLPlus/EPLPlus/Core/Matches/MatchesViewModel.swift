//
//  MatchesViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import Foundation
import Combine

// View model for MatchesView
// Inherits from BaseViewModel
final class MatchesViewModel: BaseViewModel {
    
    // Published vars for matches and matchday
    @Published var matchday: Int = 1
    @Published var matches: [Match] = []
    
    // Stores cancellable subscribers
    private var cancellables = Set<AnyCancellable>()
    
    // Override init
    override init() {
        super.init()
        addSubscribers()
    }
    
    // Add subscriber for published matches
    // When current matchday changes loads the matches for given day
    func addSubscribers() {
        footballDataManager.$currentMatchDay
            .sink { [weak self] currentMatchDay in
                self?.matchday = currentMatchDay
            }
            .store(in: &cancellables)
        footballDataManager.$matches
            .sink { [weak self] matches in
                self?.matches = matches
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self?.isLoading = false
                }
            }
            .store(in: &cancellables)
        $matchday
            .sink { [weak self] matchday in
                self?.footballDataManager.getMatches(matchday: matchday)
            }
            .store(in: &cancellables)

    }
    
    // Decrement matchday value and loads matches for that day
    func decrementMatchday() {
        if matchday > 1 {
            self.isLoading = true
            matchday -= 1
            footballDataManager.getMatches(matchday: matchday)
        }
    }
    
    // Increment matchday and load matches for that day
    func incrementMatchday() {
        if matchday < 38 {
            self.isLoading = true
            matchday += 1
            footballDataManager.getMatches(matchday: matchday)
        }
    }
}
