//
//  TeamBadgeView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import SwiftUI

// View for team crest
struct TeamCrestView: View {
    
    @StateObject var viewModel: TeamCrestViewModel
    
    init(team: Team) {
        _viewModel = StateObject(wrappedValue: TeamCrestViewModel(team: team))
    }
    
    // View changes based on loading progess of badge image
    var body: some View {
        ZStack {
            if let badgeImage = viewModel.badgeImage {
                Image(uiImage: badgeImage)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                // View thats shown if image can't be loaded
                Image(systemName: "questionMark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct TeamCrestView_Previews: PreviewProvider {
    static var previews: some View {
        TeamCrestView(team: dev.team)
    }
}
