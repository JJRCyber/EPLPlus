//
//  MatchesViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import Foundation
import Combine

final class MatchesViewModel: ObservableObject {
    
    @Published var matchday: Int = 1
    @Published var matches: [Match] = []
    @Published var animate: Bool = false

    
    private let matchesManager = MatchesManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        matchesManager.getMatches(matchday: matchday)
    }
    
    func addSubscribers() {
        matchesManager.$matches
            .sink { [weak self] matches in
                self?.matches = matches
            }
            .store(in: &cancellables)
    }
    
    func decrementMatchday() {
        if matchday > 1 {
            matchday -= 1
            matchesManager.getMatches(matchday: matchday)
        }
    }
    
    func incrementMatchday() {
        if matchday < 38 {
            matchday += 1
            matchesManager.getMatches(matchday: matchday)
        }
    }
}
