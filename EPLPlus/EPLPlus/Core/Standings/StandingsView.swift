//
//  StandingsView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import SwiftUI

struct StandingsView: View {
    
    @StateObject var viewModel = StandingsViewModel()
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                headerBar
                Spacer(minLength: 0)
                HStack(spacing: 15) {
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
                .padding(.trailing, 20)
                .font(.subheadline)
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
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StandingsView()
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}
