//
//  StandingsView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import SwiftUI

// Displays league table
struct StandingsView: View {
    
    @EnvironmentObject var viewModel: StandingsViewModel
    
    // Displays header bar and column headers
    // If API request has completed show league table
    // If loading show loading indicator
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                headerBar
                columnHeaders
                if !viewModel.isLoading {
                    standingsList
                        .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    Spacer()
                    LoadingIndicator(color: Color.theme.accent)
                }
                Spacer()
            }
        }
    }
    
    // Header bar displayed at top
    private var headerBar: some View {
        HStack {
            Text("Standings")
                .font(.title)
        }
        .padding()
    }
    
    // Headers for columns
    private var columnHeaders: some View {
        HStack(spacing: 12) {
            Text("Match Day \(viewModel.currentMatchDay)")
            Spacer()
            Text("PL")
                .frame(width: 20)
            Text("W")
                .frame(width: 15)
            Text("D")
                .frame(width: 15)
            Text("L")
                .frame(width: 15)
            Text("P")
                .frame(width: 20)
        }
        .padding(.horizontal, 20)
        .font(.subheadline)
        .foregroundColor(Color.theme.secondaryText)
    }
    
    // Loops over each league position
    private var standingsList: some View {
        List {
            ForEach(viewModel.standings) { leaguePosition in
                StandingsRowView(leaguePosition: leaguePosition)
                    .listRowBackground(Color.clear)
            }
        }
        // Allows data to be refreshed by pulling down
        .refreshable {
            viewModel.getStandings()
        }
        .listStyle(.plain)
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StandingsView()
                .toolbar(.hidden, for: .navigationBar)
                .environmentObject(StandingsViewModel())
        }
    }
}
