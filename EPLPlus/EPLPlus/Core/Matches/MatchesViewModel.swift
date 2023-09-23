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
        footballDataManager.getMatches(matchday: matchday)
    }
    
    // Add subscriber for published matches
    func addSubscribers() {
        footballDataManager.$matches
            .sink { [weak self] matches in
                self?.matches = matches
            }
            .store(in: &cancellables)
    }
    
    // Decrement matchday value and loads matches for that day
    func decrementMatchday() {
        if matchday > 1 {
            matchday -= 1
            footballDataManager.getMatches(matchday: matchday)
        }
    }
    
    // Increment matchday and load matches for that day
    func incrementMatchday() {
        if matchday < 38 {
            matchday += 1
            footballDataManager.getMatches(matchday: matchday)
        }
    }
}
