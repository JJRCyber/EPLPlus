//
//  TabBarView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Group {
                Text("Fixtures")
                    .tabItem {
                        Image(systemName: "sportscourt.fill")
                        Text("Fixtures")
                    }
                Text("Table")
                    .tabItem {
                        Image(systemName: "trophy.fill")
                        Text("Standings")
                    }
                Text("Teams")
                    .tabItem {
                        Image(systemName: "soccerball")
                        Text("Teams")
                    }
            }
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
