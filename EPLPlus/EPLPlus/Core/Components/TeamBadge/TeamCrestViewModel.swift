//
//  TeamCrestViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import SwiftUI
import Combine

class TeamCrestViewModel: ObservableObject {
    
    @Published var badgeImage: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let team: Team
    private let teamCrestManager: TeamCrestManager
    private var cancellables = Set<AnyCancellable>()
    
    init(team: Team) {
        self.isLoading = true
        self.team = team
        self.teamCrestManager = TeamCrestManager(team: team)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        teamCrestManager.$crestImage
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedBadgeImage in
                self?.badgeImage = returnedBadgeImage
            }
            .store(in: &cancellables)

    }
    
}
