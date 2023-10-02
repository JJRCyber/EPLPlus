//
//  TeamDetailView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 28/9/2023.
//

import SwiftUI
import MapKit

struct TeamDetailLoadingView: View {
    
    @Binding var selectedTeam: TeamDetail?
    @ObservedObject var teamsViewModel: TeamsViewModel
    
    var body: some View {
        ZStack {
            if let team = selectedTeam {
                TeamDetailView(teamsViewModel: teamsViewModel, team: team)
            }
        }
    }
}

struct TeamDetailView: View {
    
    @ObservedObject var teamsViewModel: TeamsViewModel
    @StateObject var viewModel: TeamDetailViewModel
    let team: TeamDetail
    
    @Environment(\.presentationMode) var presentationMode
    
    init(teamsViewModel: TeamsViewModel, team: TeamDetail) {
        self.team = team
        self.teamsViewModel = teamsViewModel
        self._viewModel = StateObject(wrappedValue: TeamDetailViewModel(address: team.address))
    }
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.theme.secondaryText)
                    }
                    
                    Spacer()
                    Button {
                        teamsViewModel.toggleTeamFavourite(team: team)
                    } label: {
                        Image(systemName: teamsViewModel.isFavouriteTeam(team: team) ? "heart.fill" : "heart")
                            .foregroundColor(teamsViewModel.isFavouriteTeam(team: team) ? Color.theme.red : Color.theme.secondaryText)
                    }
                    
                }
                .font(.title2)
                .padding()
                HStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text(team.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.accent)
                        Text("Founded: \(team.founded ?? 0)")
                            .font(.subheadline)
                            .foregroundColor(Color.theme.secondaryText)

                    }

                    Spacer()
                    TeamCrestView(team: Team(teamDetail: team))
                        .frame(width: 50, height: 50)
                }
                .padding()

                Map(coordinateRegion: $viewModel.mapRegion)
                    .frame(height: 250)
                    .allowsHitTesting(false)
                    .padding(.horizontal)
                Text(team.venue)
                    .padding(.horizontal)
                    .font(.headline)
                Text(team.address)
                    .padding(.horizontal)
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct TeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailView(teamsViewModel: TeamsViewModel(), team: dev.teamDetail)
    }
}
