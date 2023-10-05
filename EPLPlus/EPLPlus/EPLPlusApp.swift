//
//  EPLPlusApp.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import SwiftUI

// Entry point of app inits standingViewModel as environment object
// This allows loading API data while app is still loading
@main
struct EPLPlusApp: App {
    
    @StateObject private var viewModel = StandingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            // ZStack used to display launchView on top of TabBarView for 2 seconds to improve user experience
            ZStack {
                NavigationStack {
                    TabBarView()
                        .toolbar(.hidden, for: .navigationBar)
                }
                .environmentObject(viewModel)
                ZStack {
                    if viewModel.showLaunchView {
                        LaunchView(showLaunchView: $viewModel.showLaunchView)
                            .transition(AnyTransition.opacity.animation(.easeIn))
                    }
                }
                .zIndex(2.0)

            }
        }
    }
}
