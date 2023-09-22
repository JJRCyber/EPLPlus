//
//  MatchesView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import SwiftUI

struct MatchesView: View {
    
    @StateObject private var viewModel = MatchesViewModel()
    
    var body: some View {
        ZStack {
            // Background
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                headerBar
                List {
                    ForEach(viewModel.matches) { match in
                        MatchRowView(match: match)
                    }
                }
                .listStyle(.plain)
                Spacer(minLength: 0)
            }
        }
    }
    
    var headerBar: some View {
        HStack {
            CircleButtonView(iconName: "chevron.left")
                .onTapGesture {
                    viewModel.decrementMatchday()
                }
            Spacer()
            Text("Matchday \(viewModel.matchday)")
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .onTapGesture {
                    viewModel.incrementMatchday()
                }
        }
        .padding(.horizontal)
    }
}

struct FixturesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}
