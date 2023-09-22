//
//  StandingsView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import SwiftUI

struct StandingsView: View {
    
    @EnvironmentObject private var viewModel: TabBarViewModel
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                headerBar
                Spacer(minLength: 0)
                List {
                    ForEach(viewModel.standings) { leaguePosition in
                        StandingsRowView(leaguePosition: leaguePosition)
                    }
                }
                .listStyle(.plain)
                
            }
        }

    }
    
    private var headerBar: some View {
        HStack {
            Text("Standings")
                .font(.title)
        }
        .padding()
    }
    
    private var standingsList: some View {
        List {
            ForEach(viewModel.allTeams) { team in
                TeamsRowView(team: team)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                    .listRowSeparator(.hidden)
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
        }
        .environmentObject(dev.tabBarViewModel)

    }
}
