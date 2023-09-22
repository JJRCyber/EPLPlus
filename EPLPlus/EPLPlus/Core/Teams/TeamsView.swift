//
//  TeamsView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import SwiftUI

struct TeamsView: View {
    
    @StateObject private var viewModel = TeamsViewModel()
    @State private var showFavourites: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                headerBar
                Divider()
                if !showFavourites {
                    allTeamsList
                    .transition(.move(edge: .leading))
                }
                if showFavourites {
                    favouriteTeamsList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private var headerBar: some View {
        HStack {
            Text(!showFavourites ? "All Teams" : "Favourite Teams")
                .font(.title)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: !showFavourites ? "heart.fill" : "chevron.left")
                .onTapGesture {
                    withAnimation {
                        showFavourites.toggle()
                    }

                }
        }
        .padding()
    }
    
    private var allTeamsList: some View {
        List {
            ForEach(viewModel.allTeams) { teamDetail in
                TeamsRowView(teamDetail: teamDetail)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
    
    private var favouriteTeamsList: some View {
        List {
            ForEach(viewModel.favouriteTeams) { teamDetail in
                TeamsRowView(teamDetail: teamDetail)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TeamsView()
                .toolbar(.hidden, for: .navigationBar)
        }
        .environmentObject(dev.tabBarViewModel)

    }
}
