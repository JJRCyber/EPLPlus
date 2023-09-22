//
//  TeamsViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 21/9/2023.
//

import Foundation
import Combine

final class TeamsViewModel: BaseViewModel {
    
    @Published var allTeams: [Team] = []
    @Published var favouriteTeams: [Team] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        addSubscribers()
        getTeams()
    }
    
    func addSubscribers() {
        footballDataManager.$allTeams
            .map { teams in
                teams.sorted { $0.shortName < $1.shortName }
            }
            .sink { [weak self] sortedTeams in
                self?.allTeams = sortedTeams
            }
            .store(in: &cancellables)
    }
    
    private func getTeams() {
        footballDataManager.getTeams()
    }
}
