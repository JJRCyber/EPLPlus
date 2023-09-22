//
//  MatchesViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import Foundation
import Combine

final class MatchesViewModel: BaseViewModel {
    
    @Published var matchday: Int = 1
    @Published var matches: [Match] = []
    @Published var animate: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        addSubscribers()
        footballDataManager.getMatches(matchday: matchday)
    }
    
    func addSubscribers() {
        footballDataManager.$matches
            .sink { [weak self] matches in
                self?.matches = matches
            }
            .store(in: &cancellables)
    }
    
    func decrementMatchday() {
        if matchday > 1 {
            matchday -= 1
            footballDataManager.getMatches(matchday: matchday)
        }
    }
    
    func incrementMatchday() {
        if matchday < 38 {
            matchday += 1
            footballDataManager.getMatches(matchday: matchday)
        }
    }
}
