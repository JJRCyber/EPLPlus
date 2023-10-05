//
//  TeamDetailView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 28/9/2023.
//

import SwiftUI
import MapKit

// Intermediate view that is called when team is pressed
// If selectedTeam is not nil loads the TeamDetailView
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

// Team detail view that displays information about the team retrieved from API
struct TeamDetailView: View {
    
    @ObservedObject var teamsViewModel: TeamsViewModel
    @StateObject var viewModel: TeamDetailViewModel
    
    let team: TeamDetail
    
    // Allows dismissing of view when x button pressed
    @Environment(\.presentationMode) var presentationMode
    
    // Init viewModel with stadium address returned from API
    init(teamsViewModel: TeamsViewModel, team: TeamDetail) {
        self.team = team
        self.teamsViewModel = teamsViewModel
        self._viewModel = StateObject(wrappedValue: TeamDetailViewModel(address: team.address))
    }
    
    // View main sections
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
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
    
    // Displays button to close view and favourite team
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
    
    // Displays team name, team crest and year founded
    var teamHeader: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(team.shortName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.accent)
                Text(verbatim: "Founded: \(team.founded ?? 0)")
                    .font(.subheadline)
                    .foregroundColor(Color.theme.secondaryText)
                
            }
            Spacer()
            TeamCrestView(team: Team(teamDetail: team))
                .frame(width: 50, height: 50)
        }
        .padding()
    }
    
    // Shows a MapKit view of the stadium or of UK if address cannot be searched
    // Displays stadium name and address below
    var venueSection: some View {
        Group {
            Map(coordinateRegion: $viewModel.mapRegion)
                .cornerRadius(10)
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
    
    // Displays a form view using SwiftUI charts
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
    
    // Displays scrollable section with player names in team
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
            .environmentObject(StandingsViewModel())
    }
}
