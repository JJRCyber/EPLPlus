//
//  StandingsViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import Combine

// Inherits from BaseViewModel
// This view model is used on multiple pages and is initalised on app launch
// Loaded into environment as environmentObject
final class StandingsViewModel: BaseViewModel {
    
    // Published array of leaguepositions and Int for currentMatchDay
    @Published var standings: [LeaguePosition] = []
    @Published var currentMatchDay: Int = 1
    @Published var showLaunchView: Bool = true
    
    // Stores cancellable downloads
    private var cancellables = Set<AnyCancellable>()
    
    // override init
    override init() {
        super.init()
        addSubscribers()
        getStandings()
    }
    
    // Adds subscribers for footballDataManager publishers
    // Weak self used incase view is deinit while downloading
    func addSubscribers() {
        footballDataManager.$standings
            .sink { [weak self] standings in
                self?.standings = standings
                self?.isLoading = false
            }
            .store(in: &cancellables)
        footballDataManager.$currentMatchDay
            .sink { [weak self] currentMatchDay in
                self?.currentMatchDay = currentMatchDay
            }
            .store(in: &cancellables)
    }
    
    // Updates standings from API
    func getStandings() {
        isLoading = true
        footballDataManager.getStandings()
    }
    
    
}
