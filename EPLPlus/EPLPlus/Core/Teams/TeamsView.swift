//
//  TeamsView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import SwiftUI

// List view for teams and favourite teams
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
                // Transition between favourites and all teams
                if !viewModel.isLoading {
                    ZStack {
                        if !showFavourites {
                            allTeamsList
                            .transition(.move(edge: .leading))
                        }
                        if showFavourites {
                            favouriteTeamsList
                                .transition(.move(edge: .trailing))
                        }
                    }
                    .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    Spacer()
                    LoadingIndicator(color: Color.theme.accent)
                }

                Spacer(minLength: 0)
            }
            .background(
                NavigationLink(destination: TeamDetailLoadingView(selectedTeam: $viewModel.selectedTeam, teamsViewModel: viewModel), isActive: $viewModel.showTeamDetailView, label: {
                    EmptyView()
                })
            )
        }
    }
    
    // Header bar with title and favourites button
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
    
    // List of all teams
    private var allTeamsList: some View {
        List {
            ForEach(viewModel.allTeams) { teamDetail in
                TeamsRowView(teamDetail: teamDetail)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        viewModel.viewSegue(teamDetail: teamDetail)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    // List of favourite teams
    private var favouriteTeamsList: some View {
        List {
            ForEach(viewModel.favouriteTeams) { teamDetail in
                TeamsRowView(teamDetail: teamDetail)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        viewModel.viewSegue(teamDetail: teamDetail)
                    }
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
