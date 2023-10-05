//
//  LoadingIndicator.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 4/10/2023.
//

import SwiftUI

// Loading indicator used when data is being loaded from network
struct LoadingIndicator: View {
    
    let color: Color
    
    // Timer publishes value every 0.3 seconds to allow for looping animation
    // On main thread as it updates UI and autoconnects on view launch
    private let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    // Array of soccerball symboles as loading icon
    private let loadingSymbols: [Image] = [
        Image(systemName: "soccerball"),
        Image(systemName: "soccerball"),
        Image(systemName: "soccerball")
    ]
    
    // Value for counter that is incremented in a loop
    @State private var counter: Int = 0
    // Show loading indicator bool that allows opacity transition on view load
    @State private var showLoadingIndicator: Bool = false
    
    // Loading indicator fades in with opacity transition on view load
    // Displays the 3 loading symbols and offsets them based on the timer publisher
    var body: some View {
        ZStack {
            if showLoadingIndicator {
                HStack {
                    ForEach(0..<3) { index in
                        loadingSymbols[index]
                            .font(.headline)
                            .foregroundColor(color)
                            .offset(y: counter == index ? -10 : 0)
                    }
                }
                .transition(AnyTransition.opacity.animation(.easeIn))
                .onReceive(timer) { _ in
                    // When published value recived from timer increment counter
                    // Once counter == 2 set back to 0 to create loop effect
                    // Done with spring animation
                    withAnimation(.spring()) {
                        if counter == 2 {
                            counter = 0
                        } else {
                            counter += 1
                        }
                    }
                }
                
            }
        }
        // Sets showLoadingIndicator to true to trigger opacity animation
        .onAppear {
            showLoadingIndicator.toggle()
        }
        
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator(color: Color.theme.accent)
    }
}
