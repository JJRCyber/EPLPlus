//
//  EPLPlusApp.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 20/9/2023.
//

import SwiftUI

@main
struct EPLPlusApp: App {
    
    @StateObject private var viewModel = TabBarViewModel()
    
    var body: some Scene {
        WindowGroup {
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
