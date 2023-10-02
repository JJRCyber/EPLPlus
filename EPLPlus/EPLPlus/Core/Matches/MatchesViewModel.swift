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
    @Published var isLoading: Bool = true
    
    // Stores cancellable subscribers
    private var cancellables = Set<AnyCancellable>()
    
    // Override init
    override init() {
        super.init()
        addSubscribers()
        footballDataManager.getMatches(matchday: matchday)
    }
    
    // Add subscriber for published matches
    func addSubscribers() {
        footballDataManager.$currentMatchDay
            .sink { [weak self] currentMatchDay in
                self?.matchday = currentMatchDay
            }
            .store(in: &cancellables)
        footballDataManager.$matches
            .sink { [weak self] matches in
                self?.matches = matches
                self?.isLoading = false
            }
            .store(in: &cancellables)
        $matchday
            .sink { [weak self] matchday in
                self?.isLoading = true
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
    
    func refreshMatchday() {
        footballDataManager.getMatches(matchday: matchday)
    }
}
