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
    
    // Set initial region to UK using state rather than viewModel due to compiler warnings
    @State var stadiumMapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.3555, longitude: -1.1743),
        span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
    
    let team: TeamDetail
    
    // Allows dismissing of view when x button pressed
    @Environment(\.presentationMode) var presentationMode
    
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                centerOnStadium()
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
            Map(coordinateRegion: $stadiumMapRegion)
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
    
    // Uses MKLocalSearch to search for address of stadium
    // If address is found centers the mapRegion on the returned region
    // Function would usually be part of viewModel but this causes compiler warning for:
    // "Publishing changes from within view updates is not allowed, this will cause undefined behavior."
    private func centerOnStadium() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = team.address
        
        let addressSearch = MKLocalSearch(request: searchRequest)
        
        addressSearch.start { response, error in
            guard let response = response else {
                // If search is not succesfull print debugging message and leave map region as UK
                print("Could not complete address search: \(String(describing: error?.localizedDescription))")
                return
            }
            // If search succesful modify the zoom of the area and set mapRegion to returned region
            var region = response.boundingRegion
            let zoomFactor: Double = 0.8
            region.span.latitudeDelta *= zoomFactor
            region.span.longitudeDelta *= zoomFactor
            
            withAnimation(.easeIn) {
                self.stadiumMapRegion = region
            }

        }
    }
}

struct TeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailView(teamsViewModel: TeamsViewModel(), team: dev.teamDetail)
            .environmentObject(StandingsViewModel())
    }
}
