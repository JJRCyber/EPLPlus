//
//  MatchesView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import SwiftUI

// View for matches on given match day
struct MatchesView: View {
    
    @StateObject private var viewModel = MatchesViewModel()
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                headerBar
                if !viewModel.isLoading {
                    TabView(selection: $viewModel.matchday) {
                        ForEach((1...38), id: \.self) { index in
                            matchList
                                .tag(index)
                        }
                    }
                    .refreshable {
                        viewModel.refreshMatchday()
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .transition(AnyTransition.asymmetric(insertion: AnyTransition.opacity.animation(.easeIn), removal: AnyTransition.opacity.animation(.easeOut(duration: 0.1))))

                } else {
                    Spacer()
                    LoadingIndicator(color: Color.theme.accent)
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    // Buttons to increment and decrement matchday + title
    private var headerBar: some View {
        HStack {
            CircleButtonView(iconName: "chevron.left")
                .onTapGesture {
                    withAnimation {
                        viewModel.decrementMatchday()
                    }
                    
                }
            Spacer()
            Text("Matchday \(viewModel.matchday)")
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .onTapGesture {
                    withAnimation {
                        viewModel.incrementMatchday()
                    }
                    
                }
        }
        .padding(.horizontal)
    }
    
    // Loops over all matches on a given matchday
    private var matchList: some View {
        ScrollView {
            ForEach(viewModel.matches) { match in
                MatchRowView(match: match)
                    .listRowBackground(Color.clear)
                Divider()
            }
        }
        .listStyle(.plain)
    }
}

struct FixturesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}
