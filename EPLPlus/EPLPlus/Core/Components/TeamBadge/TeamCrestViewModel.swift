//
//  TeamCrestViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import SwiftUI
import Combine

// Viewmodel for TeamCrestView
final class TeamCrestViewModel: ObservableObject {
    
    // Variables for badgeImage and loading status
    @Published var badgeImage: UIImage? = nil
    @Published var isLoading: Bool = false
    
    // Constants for team and teamCrestManager instance
    private let team: Team
    private let teamCrestManager: TeamCrestManager
    
    // Set to store cancellable downloads
    private var cancellables = Set<AnyCancellable>()
    
    // Set is loading to true and init teamCrestManager with passed team
    init(team: Team) {
        self.isLoading = true
        self.team = team
        self.teamCrestManager = TeamCrestManager(team: team)
        self.addSubscribers()
    }
    
    // Subscribes to crestImage publisher
    private func addSubscribers() {
        teamCrestManager.$crestImage
        // Sets instance badge image to returned badge image
        // Sets isLoading to false
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedBadgeImage in
                self?.badgeImage = returnedBadgeImage
            }
            .store(in: &cancellables)

    }
    
}
