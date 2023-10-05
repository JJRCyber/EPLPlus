//
//  LaunchView.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 3/10/2023.
//

import SwiftUI

/*
 Launch view that displays for 2 seconds while API calls are made in background
 Provides a more seamless user experience
 */
struct LaunchView: View {
    
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.theme.launchBackground
                .ignoresSafeArea()
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            LoadingIndicator(color: Color.theme.launchAccent)
                .offset(y: 100)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                showLaunchView = false
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
