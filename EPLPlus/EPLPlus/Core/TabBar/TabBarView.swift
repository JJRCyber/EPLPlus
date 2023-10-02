//
//  TabBarView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import SwiftUI

// Root view of app
// 3 tabs for navigating to various views
struct TabBarView: View {
    var body: some View {
        TabView {
            Group {
                StandingsView()
                    .tabItem {
                        Image(systemName: "trophy.fill")
                        Text("Standings")
                    }
                MatchesView()
                    .tabItem {
                        Image(systemName: "sportscourt.fill")
                        Text("Fixtures")
                    }
                TeamsView()
                    .tabItem {
                        Image(systemName: "soccerball")
                        Text("Teams")
                    }
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TabBarView()
        }
        .toolbar(.hidden, for: .navigationBar)

    }
}
