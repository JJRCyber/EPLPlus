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
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    headerBar
                    teamHeader
                    venueSection
                    Divider()
                        .padding(.top)
                    formSection
                    Divider()
                        .padding(.top)
                    squadSection
                    Spacer()
                }
            }

        }
        .navigationBarBackButtonHidden()
    }
    
    var headerBar: some View {
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
        .padding(.horizontal)
    }
    
    var teamHeader: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(team.shortName)
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
    }
    
    var venueSection: some View {
        Group {
            Map(coordinateRegion: $viewModel.mapRegion)
                .frame(height: 200)
                .allowsHitTesting(false)
                .padding(.horizontal)
            Text(team.venue)
                .padding(.horizontal)
                .font(.headline)
            Text(team.address)
                .padding(.horizontal)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
        }
        
    }
    
    var formSection: some View {
        Group {
            HStack {
                Text("Form")
                Spacer()
                Image(systemName: "medal.fill")
            }
            .font(.title3)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal)
            .padding(.top)
            FormView(teamId: team.id)
        }
    }
    
    var squadSection: some View {
        Group {
            HStack {
                Text("Squad")
                Spacer()
                Image(systemName: "person.fill")
            }
            .font(.title3)
            .foregroundColor(Color.theme.secondaryText)
            .padding()

            ScrollView {
                ForEach(team.squad) { player in
                    SquadListRowView(player: player)
                        .listRowBackground(Color.clear)
                }
            }
            .frame(maxHeight: 250)

        }
    }
}

struct TeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailView(teamsViewModel: TeamsViewModel(), team: dev.teamDetail)
            .environmentObject(TabBarViewModel())
    }
}
