//
//  StandingsView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import SwiftUI

// Displays league table
struct StandingsView: View {
    
    @EnvironmentObject var viewModel: TabBarViewModel
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                headerBar
                Spacer(minLength: 0)
                columnHeaders
                standingsList
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
        HStack(spacing: 15) {
            Text("Match Day \(viewModel.currentMatchDay)")
            Spacer()
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
        .listStyle(.plain)
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StandingsView()
                .toolbar(.hidden, for: .navigationBar)
                .environmentObject(TabBarViewModel())
        }
    }
}
